//
//  SearchUserViewController.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit
import ViewAnimator

final class SearchUserViewController: UIViewController {

    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(R.nib.userTableViewCell)
        }
    }

    private var presenter: SearchUserPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        let model = SearchUserModel()
        presenter = SearchUserPresenter(view: self, model: model)

        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .always
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }

    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "userName"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func animateCell(fadeIn: Bool, completion: (() -> Void)? = nil) {

        let animation = AnimationType.from(direction: .bottom, offset: 30.0)
        UIView.animate(views: self.tableView.visibleCells,
                       animations: [animation],
                       reversed: !fadeIn,
                       initialAlpha: fadeIn ? 0.0 : 1.0,
                       finalAlpha: fadeIn ? 1.0 : 0.0,
                       delay: 0.0,
                       completion: completion
        )
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func reloadData() {
        self.tableView.reloadData()
        // セルをフェードイン
        animateCell(fadeIn: true)
    }

    func pushDetal(_ user: User) {
        let webdetailViewController = R.storyboard.webDetail.instantiateInitialViewController()!
        webdetailViewController.setData(user)
        self.navigationController?.pushViewController(webdetailViewController, animated: true)
    }

    func showNoResults(_ show: Bool) {
        self.noResultsLabel.isHidden = !show
        self.tableView.isHidden = show
    }
}

// MARK: - TableView

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countUsers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCell.identifier) as! UserTableViewCell
        let user = presenter.getUser(indexPath)
        cell.setData(user)
        return cell
    }

}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
}

// MARK: - SearchBar

extension SearchUserViewController: UISearchBarDelegate {
    // キャンセルボタンでリセット
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.largeTitleDisplayMode = .always
        self.tableView.setContentOffset(.zero, animated: false)
        self.animateCell(fadeIn: false) {
            self.presenter.clearResults()
            self.navigationItem.largeTitleDisplayMode = .automatic
        }

    }
    // エンターキーで検索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // セルをフェードアウト
        animateCell(fadeIn: false)
        self.presenter.searchButtonClicked(searchBar.text)
    }
}

extension SearchUserViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
}

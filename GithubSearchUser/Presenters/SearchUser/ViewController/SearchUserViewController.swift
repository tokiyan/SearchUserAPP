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
    private var users: [User] = []

    var useCase: SearchUserUseCase!
    var wireframe: SearchUserWireframe!

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension SearchUserViewController: AlertError, ShowNetworkIndicator {

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

    func searchButtonClicked(_ text: String?) {

        guard let text = text else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.clearResults()
            })
            return
        }

        self.showNetworkIndicator(true)
        useCase.get(q: text, completion: { result in
            self.showNetworkIndicator(false)
            switch result {
            case .success(let res):
                self.users = res.items
                self.reloadData()
                self.showNoResults(res.items.isEmpty)
            case .failure(let error):
                self.alertError(error)
                // エラー後にエラー前の検索結果のセルのフェードアウトが起こる現象を回避
                self.clearResults()
            }
        })
    }

    func clearResults() {
        self.users = []
        self.reloadData()
    }

    func reloadData() {
        self.tableView.reloadData()
        // セルをフェードイン
        animateCell(fadeIn: true)
    }

    func showNoResults(_ show: Bool) {
        self.noResultsLabel.isHidden = !show
        self.tableView.isHidden = show
    }
}

// MARK: - TableView

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCell.identifier) as! UserTableViewCell
        cell.setData(self.users[indexPath.row])
        return cell
    }

}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wireframe.pushWebDetail(self.users[indexPath.row])

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
            self.clearResults()
            self.navigationItem.largeTitleDisplayMode = .automatic
        }

    }
    // エンターキーで検索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // セルをフェードアウト
        animateCell(fadeIn: false)
        self.searchButtonClicked(searchBar.text)
    }
}

extension SearchUserViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
}

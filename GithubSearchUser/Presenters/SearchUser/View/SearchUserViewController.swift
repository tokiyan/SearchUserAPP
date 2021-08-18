//
//  SearchUserViewController.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import ViewAnimator

final class SearchUserViewController: UIViewController, ShowNetworkIndicator {

    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(R.nib.userTableViewCell)
        }
    }

    var viewModel: SearchUserViewModelType!

    private var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
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

// MARK: - setup & animation
extension SearchUserViewController {

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

// MARK: - bind input
extension SearchUserViewController {

    private func bindInput() {

        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.input.didTapRow)
            .disposed(by: disposeBag)
    }
}

// MARK: - bind output
extension SearchUserViewController {

    private func bindOutput() {

        viewModel.output.networkState
            .bind(to: rx.networkState)
            .disposed(by: disposeBag)

        viewModel.output.users
            .subscribe(onNext: { [weak self] in
                self?.showNoResults($0.isEmpty && self?.isSearching ?? false)
                self?.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.users.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCell.identifier) as! UserTableViewCell
        cell.setData(viewModel.output.users.value[indexPath.row])
        return cell
    }

}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            tableView.deselectRow(at: indexPath, animated: true)
        })
    }
}

// MARK: - SearchBar

extension SearchUserViewController: UISearchBarDelegate {
    // キャンセルボタンでリセット
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.navigationItem.largeTitleDisplayMode = .always
        self.tableView.setContentOffset(.zero, animated: false)
        self.animateCell(fadeIn: false) {
            self.viewModel.input.clearResult.onNext(())
            self.navigationItem.largeTitleDisplayMode = .automatic
        }

    }
    // エンターキーで検索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = true
        searchBar.resignFirstResponder()
        // セルをフェードアウト
        animateCell(fadeIn: false)
        self.viewModel.input.didTapSearchButton.onNext(searchBar.text ?? "")
    }
}

extension SearchUserViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
}

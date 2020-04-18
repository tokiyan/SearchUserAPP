//
//  SearchUserViewController.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit

final class SearchUserViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        tableView.register(R.nib.userTableViewCell)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCell.identifier) as! UserTableViewCell

        return cell
    }

}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("test")
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    // 検索バー編集開始時にキャンセルボタン有効化
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    // キャンセルボタンでキャセルボタン非表示
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    // エンターキーで検索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    // 入力された文字出力
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

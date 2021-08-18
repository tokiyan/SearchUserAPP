//
//  SearchUserPresenter.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import Foundation

protocol SearchUserPresenterInput {
    func countUsers() -> Int
    func didSelectRowAt(_ indexPath: IndexPath)
    func searchButtonClicked(_ text: String?)
    func getUser(_ indexPath: IndexPath) -> User
    func clearResults()
}

protocol SearchUserPresenterOutput: AlertError, ShowNetworkIndicator {
    func reloadData()
    func showNoResults(_ show: Bool)
}

final class SearchUserPresenterImpl: SearchUserPresenterInput {

    private var users: [User] = []
    weak var view: SearchUserPresenterOutput!
    var useCase: SearchUserUseCase!
    var wireframe: SearchUserWireframe!

    func countUsers() -> Int {
        return users.count
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        wireframe.pushWebDetail(getUser(indexPath))
    }

    func searchButtonClicked(_ text: String?) {

        guard let text = text else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.clearResults()
            })
            return
        }

        self.view.showNetworkIndicator(true)
        useCase.get(q: text, completion: { result in
            self.view.showNetworkIndicator(false)
            switch result {
            case .success(let res):
                self.users = res.items
                self.view.reloadData()
                self.view.showNoResults(res.items.isEmpty)
            case .failure(let error):
                self.view.alertError(error)
                // エラー後にエラー前の検索結果のセルのフェードアウトが起こる現象を回避
                self.clearResults()
            }
        })
    }

    func getUser(_ indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }

    func clearResults() {
        self.users = []
        self.view.reloadData()
    }
}

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
    func didSelectRowAt(_ at: IndexPath)
    func searchButtonClicked(_ text: String?)
    func getUser(_ at: IndexPath) -> User
}

protocol SearchUserPresenterOutput: AlertError, ShowNetworkIndicator {
    func reloadData()
    func pushDetal(_ user: User)
}

final class SearchUserPresenter: SearchUserPresenterInput {

    private var users: [User] = []
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput

    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }

    func countUsers() -> Int {
        return users.count
    }

    func didSelectRowAt(_ at: IndexPath) {
        view.pushDetal(getUser(at))
    }

    func searchButtonClicked(_ text: String?) {
        if text != nil {
            self.view.showNetworkIndicator(true)
            model.searchUser(q: text!, completion: { result in
                self.view.showNetworkIndicator(false)
                switch result {
                case .success(let res):
                    self.users = res.items
                    self.view.reloadData()
                case .failure(let error):
                    self.view.alertError(error)
                    // エラー後にエラー前の検索結果のセルのフェードアウトが起こる現象を回避
                    self.users = []
                    self.view.reloadData()
                }
            })
        }
    }
    func getUser(_ at: IndexPath) -> User {
        return users[at.row]
    }
}

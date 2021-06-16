//
//  WebDetailPresenter.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation

protocol WebDetailPresenterInput {
    var user: User! { get set }
    func requestUser()
}

protocol WebDetailPresenterOutput: AlertError, ShowNetworkIndicator {
    func setWebView(_ user: User)
}

final class WebDetailPresenterImpl: WebDetailPresenterInput {

    var user: User!

    weak var view: WebDetailPresenterOutput!
    var wireframe: WebDetailWireframe!

    func requestUser() {
        view.setWebView(user)
    }
}

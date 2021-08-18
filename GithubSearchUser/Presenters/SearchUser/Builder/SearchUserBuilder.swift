//
//  SearchUserBuilder.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import UIKit

final class SearchUserBuilder {

    private init() {}

    static func build() -> UIViewController {
        let viewController = R.storyboard.searchUser.instantiateInitialViewController()!
        let presenter = SearchUserPresenterImpl()
        let wireframe = SearchUserWireframeImpl()

        viewController.presenter = presenter

        presenter.view = viewController
        presenter.useCase = SearchUserUseCaseProvider.provide()
        presenter.wireframe = wireframe

        wireframe.viewController = viewController

        return viewController
    }
}

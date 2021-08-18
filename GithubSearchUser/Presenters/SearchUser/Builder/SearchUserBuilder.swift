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
        let wireframe = SearchUserWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = SearchUserViewModel(
            extra: .init(
                wireframe: wireframe,
                useCase: SearchUserUseCaseProvider.provide()
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

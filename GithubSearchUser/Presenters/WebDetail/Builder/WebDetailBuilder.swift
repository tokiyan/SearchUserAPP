//
//  WebDetailBuilder.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import UIKit

final class WebDetailBuilder {

    private init() {}

    static func build(_ user: User) -> UIViewController {
        let viewController = R.storyboard.webDetail.instantiateInitialViewController()!
        let wireframe = WebDetailWireframeImpl()

        wireframe.viewController = viewController

        let viewModel = WebDetailViewModel(
            extra: .init(
                wireframe: wireframe,
                user: user
            )
        )

        viewController.viewModel = viewModel

        return viewController
    }
}

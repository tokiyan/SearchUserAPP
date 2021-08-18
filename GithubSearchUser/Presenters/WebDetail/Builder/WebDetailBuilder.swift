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
        let presenter = WebDetailPresenterImpl()
        let wireframe = WebDetailWireframeImpl()

        viewController.presenter = presenter

        presenter.user = user
        presenter.view = viewController

        wireframe.viewController = viewController

        return viewController
    }
}

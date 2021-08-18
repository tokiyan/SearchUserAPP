//
//  WebDetailWireframe.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import UIKit

protocol WebDetailWireframe: AnyObject {}

final class WebDetailWireframeImpl: WebDetailWireframe {

    weak var viewController: UIViewController?
    weak var delegate: WebDetailWireframeDelegate?
}

protocol WebDetailWireframeDelegate: AnyObject {}

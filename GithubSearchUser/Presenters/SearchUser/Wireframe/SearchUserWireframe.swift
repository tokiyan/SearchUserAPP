//
//  SearchUserWireframe.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import UIKit

protocol SearchUserWireframe: TransitToWebDetailWireframe {}

final class SearchUserWireframeImpl: SearchUserWireframe {

    weak var viewController: UIViewController?
    weak var delegate: SearchUserWireframeDelegate?
}

protocol SearchUserWireframeDelegate: AnyObject {}

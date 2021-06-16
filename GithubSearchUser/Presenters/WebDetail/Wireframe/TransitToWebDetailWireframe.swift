//
//  TransitToWebDetailWireframe.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import UIKit

protocol TransitToWebDetailWireframe: AnyObject {
    var viewController: UIViewController? { get set }

    func pushWebDetail(_ user: User)
}

extension TransitToWebDetailWireframe {

    func pushWebDetail(_ user: User) {
        let vc = WebDetailBuilder.build(user)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

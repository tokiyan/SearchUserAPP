//
//  ShowNetworkIndicator.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/20.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol ShowNetworkIndicator {
    func showNetworkIndicator(_ show: Bool)
}

extension ShowNetworkIndicator where Self: UIViewController {

    func showNetworkIndicator(_ show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}

// MARK: - Reactive network state
extension Reactive where Base: UIViewController & ShowNetworkIndicator {

    var networkState: Binder<Bool> {
        return .init(base) { vc, state in
            vc.showNetworkIndicator(state)
        }
    }
}

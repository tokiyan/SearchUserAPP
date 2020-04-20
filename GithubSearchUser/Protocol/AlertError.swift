//
//  AlertError.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/20.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import Foundation
import UIKit

protocol AlertError: AnyObject {
    func alertError(_ error: Error)
}

extension AlertError where Self: UIViewController {

    func alertError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  WebDetailViewController.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/19.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit
import WebKit

final class WebDetailViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!

    var presenter: WebDetailPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestUser()
    }
}

extension WebDetailViewController: WebDetailPresenterOutput {

    func setWebView(_ user: User) {
        self.navigationItem.title = user.login
        let url = URL(string: user.htmlURL)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

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
    private var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()

        self.navigationItem.title = user.login
    }

    public func setData(_ user: User) {
        self.user = user
    }

    private func setupWebView() {
        let url = URL(string: user.htmlURL)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

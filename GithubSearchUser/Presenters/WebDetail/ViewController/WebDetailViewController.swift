//
//  WebDetailViewController.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/19.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

final class WebDetailViewController: UIViewController, ShowNetworkIndicator {

    @IBOutlet private weak var webView: WKWebView!

    var viewModel: WebDetailViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
    }
}

// MARK: - bind input
extension WebDetailViewController {

    private func bindInput() {

        rx.viewWillAppear
            .map { _ in () }
            .bind(to: viewModel.input.viewWillAppear)
            .disposed(by: disposeBag)
    }
}

// MARK: - bind output
extension WebDetailViewController {

    private func bindOutput() {

        viewModel.output.networkState
            .bind(to: rx.networkState)
            .disposed(by: disposeBag)

        viewModel.output.user
            .filterNil()
            .subscribe(onNext: { [weak self] user in
                self?.navigationItem.title = user.login
                let url = URL(string: user.htmlURL)
                let request = URLRequest(url: url!)
                self?.webView.load(request)
            })
            .disposed(by: disposeBag)
    }
}

//
//  UIViewController+.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/19.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

// MARK: - Reactive
/// - SeeAlso: [devxoul/RxViewController](https://github.com/devxoul/RxViewController)
extension Reactive where Base: UIViewController {

    var viewDidLoad: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewDidLoad)).map { _ in () }
    }

    var viewWillAppear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }

    var viewDidAppear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }

    var viewWillDisappear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }

    var viewDidDisappear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }

    var viewWillLayoutSubviews: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewWillLayoutSubviews)).map { _ in () }
    }

    var viewDidLayoutSubviews: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewDidLayoutSubviews)).map { _ in () }
    }

    var willMoveToParentViewController: Observable<UIViewController?> {
        return base.rx.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
    }

    var didMoveToParentViewController: Observable<UIViewController?> {
        return base.rx.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
    }

    var didReceiveMemoryWarning: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.didReceiveMemoryWarning)).map { _ in () }
    }

    var viewWillTransition: Observable<(CGSize, UIViewControllerTransitionCoordinator?)> {
        return base.rx.methodInvoked(#selector(Base.viewWillTransition))
            .map { object in
                let size = object.first as? CGSize ?? .zero
                let coordinator = object[1] as? UIViewControllerTransitionCoordinator
                return (size, coordinator)
            }
    }

    var willTransition: Observable<(UITraitCollection?, UIViewControllerTransitionCoordinator?)> {
        return base.rx.methodInvoked(#selector(Base.willTransition))
            .map { object in
                let traitCollection = object.first as? UITraitCollection
                let coordinator = object[1] as? UIViewControllerTransitionCoordinator
                return (traitCollection, coordinator)
            }
    }

    /// Rx observable, triggered when the ViewController appearance state changes (true if the View is being displayed, false otherwise)
    var isVisible: Observable<Bool> {
        let viewDidAppearObservable = self.base.rx.viewDidAppear.map { _ in true }
        let viewWillDisappearObservable = self.base.rx.viewWillDisappear.map { _ in false }
        return Observable<Bool>.merge(viewDidAppearObservable, viewWillDisappearObservable)
    }

    /// Rx observable, triggered when the ViewController is being dismissed
    var isDismissing: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.dismiss)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

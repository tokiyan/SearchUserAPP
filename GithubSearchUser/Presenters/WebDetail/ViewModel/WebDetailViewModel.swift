//
//  WebDetailViewModel.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/19.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import RxCocoa
import RxSwift
import Unio

protocol WebDetailViewModelType: AnyObject {
    var input: InputWrapper<WebDetailViewModel.Input> { get }
    var output: OutputWrapper<WebDetailViewModel.Output> { get }
}

final class WebDetailViewModel: UnioStream<WebDetailViewModel>, WebDetailViewModelType {

    convenience init(extra: Extra) {
        self.init(input: Input(),
                  state: State(),
                  extra: extra)
    }
}

extension WebDetailViewModel {

    struct Input: InputType {
        let viewWillAppear = PublishRelay<Void>()
    }

    struct Output: OutputType {
        let networkState: BehaviorRelay<Bool>
        let user: BehaviorRelay<User?>
    }

    struct State: StateType {
        let networkState = BehaviorRelay<Bool>(value: false)
        let user = BehaviorRelay<User?>(value: nil)
    }

    struct Extra: ExtraType {
        let wireframe: WebDetailWireframe
        let user: User
    }
}

extension WebDetailViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {

        let state = dependency.state
        let extra = dependency.extra

        dependency.inputObservables.viewWillAppear
            .map { extra.user }
            .bind(to: state.user)
            .disposed(by: disposeBag)

        return Output(
            networkState: state.networkState,
            user: state.user
        )
    }
}

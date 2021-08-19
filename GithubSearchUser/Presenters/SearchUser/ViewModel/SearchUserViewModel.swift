//
//  SearchUserViewModel.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/18.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Action
import RxCocoa
import RxSwift
import Unio

protocol SearchUserViewModelType: AnyObject {
    var input: InputWrapper<SearchUserViewModel.Input> { get }
    var output: OutputWrapper<SearchUserViewModel.Output> { get }
}

final class SearchUserViewModel: UnioStream<SearchUserViewModel>, SearchUserViewModelType {

    convenience init(extra: Extra) {
        self.init(input: Input(),
                  state: State(),
                  extra: extra)
    }
}

extension SearchUserViewModel {

    struct Input: InputType {
        let didTapSearchButton = PublishRelay<String>()
        let didTapRow = PublishRelay<Int>()
        let clearResult = PublishRelay<Void>()
    }

    struct Output: OutputType {
        let networkState: BehaviorRelay<Bool>
        let users: BehaviorRelay<[User]>
    }

    struct State: StateType {
        let networkState = BehaviorRelay<Bool>(value: false)
        let response = BehaviorRelay<SearchUserResponse?>(value: nil)
        let users = BehaviorRelay<[User]>(value: [])
    }

    struct Extra: ExtraType {
        let wireframe: SearchUserWireframe!
        let useCase: SearchUserUseCase!
    }
}

extension SearchUserViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {

        let state = dependency.state
        let extra = dependency.extra

        let fetchDataAction = Action<String, SearchUserResponse> {
            extra.useCase.get($0)
        }

        fetchDataAction.elements
            .bind(to: state.response)
            .disposed(by: disposeBag)

        state.response
            .filterNil()
            .map { $0.items }
            .bind(to: state.users)
            .disposed(by: disposeBag)

        dependency.inputObservables.didTapSearchButton
            .subscribe(onNext: {
                fetchDataAction.execute($0)
            })
            .disposed(by: disposeBag)

        dependency.inputObservables.didTapRow
            .subscribe(onNext: {
                extra.wireframe.pushWebDetail(state.users.value[$0])
            })
            .disposed(by: disposeBag)

        dependency.inputObservables.clearResult
            .subscribe(onNext: {
                state.users.accept([])
            })
            .disposed(by: disposeBag)

        return Output(
            networkState: state.networkState,
            users: state.users
        )
    }
}

//
//  SearchUserUseCase.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import RxSwift

final class SearchUserUseCaseProvider {

    private init() {}

    static func provide() -> SearchUserUseCase {
        return SearchUserUseCaseImpl(repository: SearchUserRepositoryProvider.provide())
    }
}

protocol SearchUserUseCase {
    func get(_ q: String) -> Observable<SearchUserResponse>
}

final class SearchUserUseCaseImpl: SearchUserUseCase {

    private let repository: SearchUserRepository

    init(repository: SearchUserRepository) {
        self.repository = repository
    }

    func get(_ q: String) -> Observable<SearchUserResponse> {
        repository.get(q)
    }
}

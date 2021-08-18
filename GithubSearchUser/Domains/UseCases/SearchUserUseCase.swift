//
//  SearchUserUseCase.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation

final class SearchUserUseCaseProvider {

    private init() {}

    static func provide() -> SearchUserUseCase {
        return SearchUserUseCaseImpl(repository: SearchUserRepositoryProvider.provide())
    }
}

protocol SearchUserUseCase {
    func get(q: String, completion: @escaping (Result) -> Void)
}

final class SearchUserUseCaseImpl: SearchUserUseCase {

    private let repository: SearchUserRepository

    init(repository: SearchUserRepository) {
        self.repository = repository
    }

    func get(q: String, completion: @escaping (Result) -> Void) {
        repository.get(q: q, completion: completion)
    }
}

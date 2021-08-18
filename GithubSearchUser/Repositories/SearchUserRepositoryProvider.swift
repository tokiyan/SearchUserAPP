//
//  SearchUserRepositoryProvider.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import RxSwift

final class SearchUserRepositoryProvider {

    private init() {}

    static func provide() -> SearchUserRepository {
        return SearchUserRepositoryImpl(api: SearchUserAPIGatewayProvider.provide())
    }
}

protocol SearchUserRepository {
    func get(_ q: String) -> Observable<SearchUserResponse>
}

final class SearchUserRepositoryImpl: SearchUserRepository {

    private let api: SearchUserAPIGateway

    init(api: SearchUserAPIGateway) {
        self.api = api
    }

    func get(_ q: String) -> Observable<SearchUserResponse> {
        api.get(q)
    }
}

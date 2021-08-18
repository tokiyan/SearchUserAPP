//
//  SearchUserAPIGatewayProvider.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final public class SearchUserAPIGatewayProvider {

    private init() {}

    static public func provide() -> SearchUserAPIGateway {
        return SearchUserAPIGatewayImpl()
    }
}

public protocol SearchUserAPIGateway {
    func get(_ q: String) -> Observable<SearchUserResponse>
}

final class SearchUserAPIGatewayImpl: SearchUserAPIGateway {

    func get(_ q: String) -> Observable<SearchUserResponse> {
        AF.request(GetSearchUserRequest(q: q))
    }
}

//
//  GetSearchUserRequest.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire

struct GetSearchUserRequest: Requestable {

    let q: String

    var path: String {
        return "search/users"
    }

    var method: HTTPMethod {
        return .get
    }

    var queryParameters: [String: Any]? {
        return ["q": q]
    }
}

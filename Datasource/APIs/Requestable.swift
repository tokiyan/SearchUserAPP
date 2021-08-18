//
//  Requestable.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {

    associatedtype Response: Codable

    var path: String { get }

    var method: HTTPMethod { get }

    var queryParameters: [String: Any]? { get }
}

extension Requestable {

    var baseURL: String {
        return "https://api.github.com/"
    }

    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }

    var requestURL: String {
        return baseURL + path
    }
}

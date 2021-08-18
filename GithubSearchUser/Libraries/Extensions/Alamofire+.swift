//
//  Alamofire+.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/17.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.Session {

    func request(_ request: Requestable, handler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(request.requestURL, method: request.method, parameters: request.queryParameters, encoding: URLEncoding(destination: .queryString), headers: request.headers).responseJSON { response in
            handler(response)
        }
    }
}

//
//  SearchUserAPIGatewayProvider.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/06/16.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire

final public class SearchUserAPIGatewayProvider {

    private init() {}

    static public func provide() -> SearchUserAPIGateway {
        return SearchUserAPIGatewayImpl()
    }
}

public protocol SearchUserAPIGateway {
    func get(q: String, completion: @escaping (Result) -> Void)
}

final class SearchUserAPIGatewayImpl: SearchUserAPIGateway {

    func get(q: String, completion: @escaping (Result) -> Void) {
        let request = GetSearchUserRequest(q: q)
        AF.request(request.requestURL, method: request.method, parameters: request.queryParameters, encoding: URLEncoding(destination: .queryString), headers: request.headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(res))

                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

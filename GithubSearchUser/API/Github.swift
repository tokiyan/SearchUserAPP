//
//  Github.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/19.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire

public enum Result {
    case success(Response)
    case failure(Error)
}

// MARK: - Github API
final class Github {

    private let baseURL = "https://api.github.com/"

    func searchUser(q: String, completion: @escaping (Result) -> Void) {

        let url = "\(baseURL)search/users"
        let parameters: [String: Any] = ["q": q]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(res))

            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

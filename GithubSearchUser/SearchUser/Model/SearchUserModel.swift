//
//  SearchUserModel.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import Foundation

protocol SearchUserModelInput {
    func searchUser(q: String, completion: @escaping (Result) -> Void)
}

final class SearchUserModel: SearchUserModelInput {
    func searchUser(q: String, completion: @escaping (Result) -> Void) {
        Github().searchUser(q: q, completion: { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

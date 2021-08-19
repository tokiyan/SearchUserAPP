//
//  Alamofire+.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/17.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Alamofire.Session {

    func request<T: Requestable>(_ request: T, handler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(request.requestURL, method: request.method, parameters: request.queryParameters, encoding: URLEncoding(destination: .queryString), headers: request.headers).responseJSON { response in
            handler(response)
        }
    }

    func request<T: Requestable>(_ request: T) -> Observable<T.Response> {
        return Single.create { observer -> Disposable in
            AF.request(request) { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let res = try JSONDecoder().decode(T.Response.self, from: data)
                        observer(.success(res))

                    } catch let error {
                        observer(.failure(error))
                    }
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
        .asObservable()
        .catch { error -> Observable<T.Response> in
            return .error(error)
        }
    }
}

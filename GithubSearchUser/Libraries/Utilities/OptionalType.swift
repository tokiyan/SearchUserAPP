//
//  OptionalType.swift
//  GithubSearchUser
//
//  Created by Tokiya on 2021/08/18.
//  Copyright © 2021 TOKIYA. All rights reserved.
//

import Foundation

protocol OptionalType {
    associatedtype Wrapped

    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? { return self }
}

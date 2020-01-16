//
//  Response.swift
//  PictionSDK
//
//  Created by jhseo on 17/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SuccessClosure<T> = (T) -> Void
public typealias FailureClosure = (ErrorType) -> Void

public protocol Response: Mappable {
    func toDict() -> [String: Any?]
}

extension Response {
    func toJSON(dict: [String: Any?]) throws -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
            return ""
        }
        return String.init(data: data, encoding: .utf8) ?? ""
    }
}

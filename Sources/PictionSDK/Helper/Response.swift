//
//  Response.swift
//  PictionSDK
//
//  Created by jhseo on 17/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public protocol Response: Mappable {
    func toDict() -> [String: Any?]
}

extension Response {
    func toJSON(dict: [String: Any?]) throws -> String {
        let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return String.init(data: data, encoding: .utf8) ?? ""
    }
}


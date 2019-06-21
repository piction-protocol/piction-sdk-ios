//
//  AuthenticationModel.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias AuthenticationViewResponse = AuthenticationModel

public struct AuthenticationModel: Response {
    public let accessToken: String?

    public init(map: Mapper) throws {
        accessToken = map.optionalFrom("accessToken")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "accessToken": accessToken
        ]
    }
}

extension AuthenticationModel {
    static func sampleData() -> [String: Any] {
        return [
            "accessToken": "329726eb-342e-4b53-bb38-6649f6aaee36"
        ]
    }
}

//
//  UserModel.swift
//  PictionSDK
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias UserViewResponse = UserModel

public struct UserModel: Response {
    public let createdAt: Date?
    public let email: String?
    public let loginId: String?
    public let picture: String?
    public let username: String?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        email = map.optionalFrom("email")
        loginId = map.optionalFrom("loginId")
        picture = map.optionalFrom("picture")
        username = map.optionalFrom("username")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt,
            "email": email,
            "loginId": loginId,
            "picture": picture,
            "username": username
        ]
    }
}

extension UserModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "email": "piction@piction.network",
            "loginId": "piction",
            "picture": "4200deeba2bde9aea76e4d1842a43c0a0eca2f8b",
            "username": "PictionCreator"
        ]
    }
}



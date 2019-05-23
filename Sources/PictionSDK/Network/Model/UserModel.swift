//
//  UserModel.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct UserModel: Mappable {
    public let username: String?

    public init(map: Mapper) throws {
        username = map.optionalFrom("username")
    }
}

extension UserModel {
    static func sampleData() -> [String: Any] {
        return [
            "username": "PictionCreator"
        ]
    }
}

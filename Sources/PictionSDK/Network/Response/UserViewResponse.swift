//
//  UserViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct UserViewResponse: Mappable {
    public let createdAt: String?
    public let email: String?
    public let name: String?
    public let picture: String?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        email = map.optionalFrom("email")
        name = map.optionalFrom("name")
        picture = map.optionalFrom("picture")
    }
}

extension UserViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-05-30T03:22:18.480Z",
            "email": "piction@piction.network",
            "name": "PictionCreator",
            "picture": "4200deeba2bde9aea76e4d1842a43c0a0eca2f8b"
        ]
    }
}

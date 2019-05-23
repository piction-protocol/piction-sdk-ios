//
//  AuthenticationResponse.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct AuthenticationResponse: Mappable {
    public let accessToken: String?

    public init(map: Mapper) throws {
        accessToken = map.optionalFrom("accessToken")
    }
}

extension AuthenticationResponse {
    static func sampleData() -> [String: Any] {
        return [
            "accessToken": "329726eb-342e-4b53-bb38-6649f6aaee36"
        ]
    }
}

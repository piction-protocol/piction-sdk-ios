//
//  CurrentUserResponse.swift
//  PictionSDK
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct CurrentUserResponse: Mappable {
    public let user: UserModel?
    public let wallet: WalletModel?

    public init(map: Mapper) throws {
        user = map.optionalFrom("user")
        wallet = map.optionalFrom("wallet")
    }
}

extension CurrentUserResponse {
    static func sampleData() -> [String: Any] {
        return [
            "user": UserModel.sampleData(),
            "wallet": WalletModel.sampleData()
        ]
    }
}

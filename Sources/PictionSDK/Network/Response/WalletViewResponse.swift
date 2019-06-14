//
//  WalletViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct WalletViewResponse: Mappable {
    public let amount: Int?
    public let publicKey: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        publicKey = map.optionalFrom("publicKey")
    }
}

extension WalletViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "publicKey": "0xcf35fcfa21a89c032b87cf35fcfa21a89c032b87"
        ]
    }
}

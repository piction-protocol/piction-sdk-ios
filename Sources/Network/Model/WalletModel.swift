//
//  WalletModel.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct WalletModel: Mappable {
    public let publicKey: String?

    public init(map: Mapper) throws {
        publicKey = map.optionalFrom("publicKey")
    }
}

extension WalletModel {
    static func sampleData() -> [String: Any] {
        return [
            "publicKey": "0xcf35fcfa21a89c032b87cf35fcfa21a89c032b87"
        ]
    }
}

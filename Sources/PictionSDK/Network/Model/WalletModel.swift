//
//  WalletModel.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias WalletViewResponse = WalletModel

public struct WalletModel: Response {
    public let amount: Int?
    public let publicKey: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        publicKey = map.optionalFrom("publicKey")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "publicKey": publicKey
        ]
    }
}

extension WalletModel {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "publicKey": "0xcf35fcfa21a89c032b87cf35fcfa21a89c032b87"
        ]
    }
}

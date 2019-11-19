//
//  TransactionSponsorshipModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/11/19.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias TransactionSponsorshipViewResponse = TransactionSponsorshipModel

public struct TransactionSponsorshipModel: Response {
    public let amount: Int?
    public let blockNumber: Int?
    public let creator: UserModel?
    public let from: String?
    public let sponsor: UserModel?
    public let to: String?
    public let txHash: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        blockNumber = map.optionalFrom("blockNumber")
        creator = map.optionalFrom("creator")
        from = map.optionalFrom("from")
        sponsor = map.optionalFrom("sponsor")
        to = map.optionalFrom("to")
        txHash = map.optionalFrom("txHash")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "blockNumber": blockNumber,
            "creator": creator,
            "from": from,
            "sponsor": sponsor,
            "to": to,
            "txHash": txHash
        ]
    }
}

extension TransactionSponsorshipModel {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "blockNumber": 0,
            "creator": UserModel.sampleData(),
            "from": "0x9983429384823984",
            "sponsor": UserModel.sampleData(),
            "to": "0x9983429384823984123",
            "txHash": "0x9983429384823984123115"
        ]
    }
}

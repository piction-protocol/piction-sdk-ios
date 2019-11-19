//
//  TransactionSubscriptionModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/11/19.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias TransactionSubscriptionViewResponse = TransactionSubscriptionModel

public struct TransactionSubscriptionModel: Response {
    public let amount: Int?
    public let blockNumber: Int?
    public let creator: UserModel?
    public let fanPassName: String?
    public let from: String?
    public let orderNo: Int?
    public let projectName: String?
    public let subscriber: UserModel?
    public let to: String?
    public let txHash: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        blockNumber = map.optionalFrom("blockNumber")
        creator = map.optionalFrom("creator")
        fanPassName = map.optionalFrom("fanPassName")
        from = map.optionalFrom("from")
        orderNo = map.optionalFrom("orderNo")
        projectName = map.optionalFrom("projectName")
        subscriber = map.optionalFrom("subscriber")
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
            "fanPassName": fanPassName,
            "from": from,
            "orderNo": orderNo,
            "projectName": projectName,
            "subscriber": subscriber,
            "to": to,
            "txHash": txHash
        ]
    }
}

extension TransactionSubscriptionModel {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "blockNumber": 0,
            "creator": UserModel.sampleData(),
            "fanPassName": "vip",
            "from": "0x9983429384823984",
            "orderNo": 0,
            "projectName": "projectName",
            "subscriber": UserModel.sampleData(),
            "to": "0x9983429384823984123",
            "txHash": "0x9983429384823984123115"
        ]
    }
}

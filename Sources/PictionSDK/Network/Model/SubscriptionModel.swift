//
//  SubscriptionModel.swift
//  PictionSDK
//
//  Created by jhseo on 20/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SubscriptionViewResponse = SubscriptionModel

public struct SubscriptionModel: Response {
    public let cpRevenue: Int?
    public let creator: UserModel?
    public let expireDate: Date?
    public let fanPass: FanPassModel?
    public let orderNo: Int?
    public let subscriber: UserModel?
    public let createAt: Date?
    public let paidPrice: Int?
    public let startedAt: Date?
    public let transactionStatus: String?

    public init(map: Mapper) throws {
        cpRevenue = map.optionalFrom("cpRevenue")
        creator = map.optionalFrom("creator")
        expireDate = map.optionalFrom("expireDate")
        fanPass = map.optionalFrom("fanPass")
        orderNo = map.optionalFrom("orderNo")
        subscriber = map.optionalFrom("subscriber")
        createAt = map.optionalFrom("createAt")
        paidPrice = map.optionalFrom("paidPrice")
        startedAt = map.optionalFrom("startedAt")
        transactionStatus = map.optionalFrom("transactionStatus")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "cpRevenue": cpRevenue,
            "creator": creator,
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "fanPass": fanPass,
            "orderNo": orderNo,
            "subscriber": subscriber,
            "createAt": createAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "paidPrice": paidPrice,
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "transactionStatus": transactionStatus,
        ]
    }
}

extension SubscriptionModel {
    static func sampleData() -> [String: Any] {
        return [
            "cpRevenue": 0,
            "creator": UserModel.sampleData(),
            "expireDate": "2019-06-20T09:27:53.127+0000",
            "fanPass": FanPassModel.sampleData(),
            "orderNo": 0,
            "subscriber": UserModel.sampleData(),
            "createAt": "2019-06-20T09:27:53.127+0000",
            "paidPrice": 0,
            "startedAt": "2019-06-20T09:27:53.127+0000",
            "transactionStatus": "SUCCESS",
        ]
    }
}

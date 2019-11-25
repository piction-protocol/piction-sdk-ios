//
//  SubscriptionUserModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/10/25.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias SubscriptionUserViewResponse = SubscriptionUserModel

public struct SubscriptionUserModel: Response {
    public let orderNo: Int?
    public let subscriber: UserModel?
    public let creator: UserModel?
    public let fanPass: FanPassModel?
    public let startedAt: Date?
    public let expireDate: Date?
    public let paidPrice: Int?
    public let cpRevenue: Int?
    public let createdAt: Date?
    public let transactionStatus: String?
    public let status: Bool?

    public init(map: Mapper) throws {
        orderNo = map.optionalFrom("orderNo")
        subscriber = map.optionalFrom("subscriber")
        creator = map.optionalFrom("creator")
        fanPass = map.optionalFrom("fanPass")
        startedAt = map.optionalFrom("startedAt")
        expireDate = map.optionalFrom("expireDate")
        paidPrice = map.optionalFrom("paidPrice")
        cpRevenue = map.optionalFrom("cpRevenue")
        createdAt = map.optionalFrom("createdAt")
        transactionStatus = map.optionalFrom("transactionStatus")
        status = map.optionalFrom("status")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "orderNo": orderNo,
            "subscriber": subscriber,
            "creator": creator,
            "fanPass": fanPass,
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "paidPrice": paidPrice,
            "cpRevenue": cpRevenue,
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "transactionStatus": transactionStatus,
            "status": status
        ]
    }
}

extension SubscriptionUserModel {
    static func sampleData() -> [String: Any] {
        return [
            "orderNo": 0,
            "subscriber": UserModel.sampleData(),
            "creator": UserModel.sampleData(),
            "fanPass": FanPassModel.sampleData(),
            "startedAt": "2019-06-20T09:27:53.127+0000",
            "expireDate": "2019-06-20T09:27:53.127+0000",
            "paidPrice": 0,
            "cpRevenue": 0,
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "transactionStatus": "SUCCESS",
            "status": true,
        ]
    }
}

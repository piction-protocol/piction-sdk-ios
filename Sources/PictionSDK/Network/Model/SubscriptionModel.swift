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
    public let creator: UserModel?
    public let expireDate: Date?
    public let fanPass: FanPassModel?
    public let orderNo: Int?
    public let subscriber: UserModel?

    public init(map: Mapper) throws {
        creator = map.optionalFrom("creator")
        expireDate = map.optionalFrom("expireDate")
        fanPass = map.optionalFrom("fanPass")
        orderNo = map.optionalFrom("orderNo")
        subscriber = map.optionalFrom("subscriber")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "creator": creator,
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "fanPass": fanPass,
            "orderNo": orderNo,
            "subscriber": subscriber
        ]
    }
}

extension SubscriptionModel {
    static func sampleData() -> [String: Any] {
        return [
            "creator": UserModel.sampleData(),
            "expireDate": "2019-06-20T09:27:53.127+0000",
            "fanPass": FanPassModel.sampleData(),
            "orderNo": 0,
            "subscriber": UserModel.sampleData()
        ]
    }
}

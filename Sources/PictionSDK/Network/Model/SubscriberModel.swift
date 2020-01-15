//
//  SubscriberModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/15.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias SubscriberViewResponse = SubscriberModel

public struct SubscriberModel: Response {
    public let createdAt: Date?
    public let expireDate: Date?
    public let fanPass: FanPassModel?
    public let startedAt: Date?
    public let status : Bool?
    public let subscriber: UserModel?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        expireDate = map.optionalFrom("expireDate")
        fanPass = map.optionalFrom("fanPass")
        startedAt = map.optionalFrom("startedAt")
        status = map.optionalFrom("status")
        subscriber = map.optionalFrom("subscriber")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "fanPass": fanPass?.toDict(),
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "status": status,
            "subscriber": subscriber?.toDict()
        ]
    }
}

extension SubscriberModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-10-18T03:45:11.736Z",
            "createdAt": "2019-10-18T03:45:11.736Z",
            "fanPass": FanPassModel.sampleData(),
            "startedAt": "2019-10-18T03:45:11.736Z",
            "status": true,
            "subscriber": UserModel.sampleData()
        ]
    }
}

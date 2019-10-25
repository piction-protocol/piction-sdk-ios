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
    public let subscriptionDate: Date?
    public let user: UserModel?

    public init(map: Mapper) throws {
        subscriptionDate = map.optionalFrom("subscriptionDate")
        user = map.optionalFrom("user")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "subscriptionDate": subscriptionDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "user": user
        ]
    }
}

extension SubscriptionUserModel {
    static func sampleData() -> [String: Any] {
        return [
            "subscriptionDate": "2019-06-20T09:27:53.127+0000",
            "user": UserModel.sampleData()
        ]
    }
}

//
//  SponsoredPlanModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/15.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SponsoredPlanViewResponse = SponsoredPlanModel

public struct SponsoredPlanModel: Response {
    public let expireDate: Date?
    public let membership: MembershipModel?
    public let startedAt: Date?
    public let status: Bool?

    public init(map: Mapper) throws {
        expireDate = map.optionalFrom("expireDate")
        membership = map.optionalFrom("membership")
        startedAt = map.optionalFrom("startedAt")
        status = map.optionalFrom("status")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "membership": membership,
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "status": status,
        ]
    }
}

extension SponsoredPlanModel {
    static func sampleData() -> [String: Any] {
        return [
            "expireDate": "2019-06-20T09:27:53.127+0000",
            "membership": MembershipModel.sampleData(),
            "startedAt": "2019-06-20T09:27:53.127+0000",
            "status": true,
        ]
    }
}

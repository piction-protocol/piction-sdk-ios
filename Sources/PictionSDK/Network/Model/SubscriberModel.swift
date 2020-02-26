//
//  SponsorModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/15.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias SponsorViewResponse = SponsorModel

public struct SponsorModel: Response {
    public let createdAt: Date?
    public let expireDate: Date?
    public let membership: MembershipModel?
    public let startedAt: Date?
    public let status : Bool?
    public let sponsor: UserModel?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        expireDate = map.optionalFrom("expireDate")
        membership = map.optionalFrom("membership")
        startedAt = map.optionalFrom("startedAt")
        status = map.optionalFrom("status")
        sponsor = map.optionalFrom("sponsor")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "membership": membership?.toDict(),
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "status": status,
            "sponsor": sponsor?.toDict()
        ]
    }
}

extension SponsorModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-10-18T03:45:11.736Z",
            "createdAt": "2019-10-18T03:45:11.736Z",
            "membership": MembershipModel.sampleData(),
            "startedAt": "2019-10-18T03:45:11.736Z",
            "status": true,
            "sponsor": UserModel.sampleData()
        ]
    }
}

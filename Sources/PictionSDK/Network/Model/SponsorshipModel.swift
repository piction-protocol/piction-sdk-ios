//
//  SponsorshipModel.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias SponsorshipViewResponse = SponsorshipModel

public struct SponsorshipModel: Response {
    public let amount: Int?
    public let createdAt: Date?
    public let creatorName: String?
    public let creatorPicture: String?
    public let id: Int?
    public let status: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        createdAt = map.optionalFrom("createdAt")
        creatorName = map.optionalFrom("creatorName")
        creatorPicture = map.optionalFrom("creatorPicture")
        id = map.optionalFrom("id")
        status = map.optionalFrom("status")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "creatorName": creatorName,
            "creatorPicture": creatorPicture,
            "id": id,
            "status": status,
        ]
    }
}

extension SponsorshipModel {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "createdAt": "2019-07-10T08:51:40.935Z",
            "creatorName": "작가이름",
            "creatorPicture": "",
            "id": 1,
            "status": "SUCCESS",
        ]
    }
}


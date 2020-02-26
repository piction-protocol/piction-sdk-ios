//
//  MembershipModel.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias MembershipViewResponse = MembershipModel

public struct MembershipModel: Response {
    public let createdAt: Date?
    public let description: String?
    public let id: Int?
    public let level: Int?
    public let name: String?
    public let postCount: Int?
    public let sponsorCount: Int?
    public let sponsorLimit: Int?
    public let price: Int?
    public let thumbnail: String?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        description = map.optionalFrom("description")
        id = map.optionalFrom("id")
        level = map.optionalFrom("level")
        name = map.optionalFrom("name")
        postCount = map.optionalFrom("postCount")
        sponsorCount = map.optionalFrom("sponsorCount")
        sponsorLimit = map.optionalFrom("sponsorLimit")
        price = map.optionalFrom("price")
        thumbnail = map.optionalFrom("thumbnail")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "description": description,
            "id": id,
            "level": level,
            "name": name,
            "postCount": postCount,
            "sponsorCount": sponsorCount,
            "sponsorLimit": sponsorLimit,
            "price": price,
            "thumbnail": thumbnail
        ]
    }
}

extension MembershipModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-07-10T08:51:40.935Z",
            "description": "설명",
            "id": 0,
            "level": 0,
            "name": "작가이름",
            "postCount": 0,
            "sponsorCount": 0,
            "sponsorLimit": 100,
            "price": 0,
            "thumbnail": ""
        ]
    }
}

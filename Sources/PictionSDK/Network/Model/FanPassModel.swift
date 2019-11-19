//
//  FanPassModel.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias FanPassViewResponse = FanPassModel

public struct FanPassModel: Response {
    public let createdAt: Date?
    public let description: String?
    public let id: Int?
    public let level: Int?
    public let name: String?
    public let status: Bool?
    public let subscriptionCount: Int?
    public let subscriptionLimit: Int?
    public let subscriptionPrice: Int?
    public let thumbnail: String?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        description = map.optionalFrom("description")
        id = map.optionalFrom("id")
        level = map.optionalFrom("level")
        name = map.optionalFrom("name")
        status = map.optionalFrom("status")
        subscriptionCount = map.optionalFrom("subscriptionCount")
        subscriptionLimit = map.optionalFrom("subscriptionLimit")
        subscriptionPrice = map.optionalFrom("subscriptionPrice")
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
            "status": status,
            "subscriptionCount": subscriptionCount,
            "subscriptionLimit": subscriptionLimit,
            "subscriptionPrice": subscriptionPrice,
            "thumbnail": thumbnail
        ]
    }
}

extension FanPassModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-07-10T08:51:40.935Z",
            "description": "설명",
            "id": 0,
            "level": 0,
            "name": "작가이름",
            "status": true,
            "subscriptionCount": 0,
            "subscriptionLimit": 100,
            "subscriptionPrice": 0,
            "thumbnail": ""
        ]
    }
}

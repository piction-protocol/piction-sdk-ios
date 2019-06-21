//
//  SeriesModel.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SeriesViewResponse = SeriesModel

public struct SeriesModel: Response {
    public let createdAt: Date
    public let id: Int?
    public let name: String?
    public let postCount: Int?
    public let priority: Int?

    public init(map: Mapper) throws {
        createdAt = try map.from("createdAt")
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        postCount = map.optionalFrom("postCount")
        priority = map.optionalFrom("priority")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt,
            "id": id,
            "name": name,
            "postCount": postCount,
            "priority": priority
        ]
    }
}

extension SeriesModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "id": 0,
            "name": "나의시리즈",
            "postCount": 0,
            "priority": 0,
        ]
    }
}

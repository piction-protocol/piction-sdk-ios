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
    public let createdAt: Date?
    public let id: Int?
    public let name: String?
    public let postCount: Int?
    public let priority: Int?
    public let thumbnails: [String]?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        postCount = map.optionalFrom("postCount")
        priority = map.optionalFrom("priority")
        thumbnails = map.optionalFrom("thumbnails")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "name": name,
            "postCount": postCount,
            "priority": priority,
            "thumbnails": thumbnails
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
            "thumbnails": []
        ]
    }
}

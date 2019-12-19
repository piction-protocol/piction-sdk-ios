//
//  CategoryModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/12/19.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias CategoryViewResponse = CategoryModel

public struct CategoryModel: Response {
    public let categorizedCount: Int?
    public let createdAt: Date?
    public let id: Int?
    public let name: String?
    public let priority: Int?
    public let status: String?
    public let thumbnail: String?

    public init(map: Mapper) throws {
        categorizedCount = map.optionalFrom("categorizedCount")
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        priority = map.optionalFrom("priority")
        status = map.optionalFrom("status")
        thumbnail = map.optionalFrom("thumbnail")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "categorizedCount": categorizedCount,
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "name": name,
            "priority": priority,
            "status": status,
            "thumbnail": thumbnail
        ]
    }
}

extension CategoryModel {
    static func sampleData() -> [String: Any] {
        return [
            "categorizedCount": 0,
            "createdAt": "2019-12-19T09:00:02.404Z",
            "id": 0,
            "name": "string",
            "priority": 0,
            "status": true,
            "thumbnail": "string"
        ]
    }
}

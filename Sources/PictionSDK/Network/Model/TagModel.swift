//  TagModel.swift
//  PictionSDK
//
//  Created by jhseo on 18/10/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias TagViewResponse = TagModel

public struct TagModel: Response {
    public let createdAt: Date?
    public let id: Int?
    public let label: String?
    public let name: String?
    public let taggingCount: Int?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        label = map.optionalFrom("label")
        name = map.optionalFrom("name")
        taggingCount = map.optionalFrom("taggingCount")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "label": label,
            "name": name,
            "taggingCount": taggingCount
        ]
    }
}

extension TagModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-10-18T03:45:11.736Z",
            "id": 0,
            "label": "string",
            "name": "string",
            "taggingCount": 0
        ]
    }
}

//
//  SeriesViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias SeriesModel = SeriesViewResponse

public struct SeriesViewResponse: Mappable {
    public let createdAt: String?
    public let id: Int?
    public let name: String?
    public let postCount: Int?
    public let priority: Int?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        postCount = map.optionalFrom("postCount")
        priority = map.optionalFrom("priority")
    }
}

extension SeriesViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-06-14T02:35:06.346Z",
            "id": 0,
            "name": "나의시리즈",
            "postCount": 0,
            "priority": 0,
        ]
    }
}

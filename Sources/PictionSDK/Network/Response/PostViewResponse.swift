//
//  PostViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias PostModel = PostViewResponse

public struct PostViewResponse: Mappable {
    public let content: String?
    public let cover: String?
    public let createdAt: String?
    public let id: String?
    public let series: String?
    public let status: String?
    public let title: String?

    public init(map: Mapper) throws {
        content = map.optionalFrom("content")
        cover = map.optionalFrom("cover")
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        series = map.optionalFrom("series")
        status = map.optionalFrom("status")
        title = map.optionalFrom("title")
    }
}

extension PostViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "content": "content",
            "cover": "string",
            "createdAt": "2019-06-13T01:23:04.413Z",
            "id": "id",
            "series": "series",
            "status": "status",
            "title": "title"
        ]
    }
}

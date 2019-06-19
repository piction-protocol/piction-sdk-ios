//
//  PostViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias PostModel = PostViewResponse

public struct PostViewResponse: Response {
    public let content: String?
    public let cover: String?
    public let createdAt: String?
    public let id: String?
    public let likeCount: Int?
    public let series: SeriesModel?
    public let status: String?
    public let title: String?

    public init(map: Mapper) throws {
        content = map.optionalFrom("content")
        cover = map.optionalFrom("cover")
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        likeCount = map.optionalFrom("likeCount")
        series = map.optionalFrom("series")
        status = map.optionalFrom("status")
        title = map.optionalFrom("title")
    }

    public func toJSONString() throws -> String {
         return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "content": content,
            "cover": cover,
            "createdAt": createdAt,
            "id": id,
            "series": series?.toDict(),
            "status": status,
            "title": title,
        ]
    }
}

extension PostViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "content": "content",
            "cover": "string",
            "createdAt": "2019-06-13T01:23:04.413Z",
            "id": "id",
            "likeCount": 0,
            "series": SeriesModel.sampleData(),
            "status": "status",
            "title": "title"
        ]
    }
}

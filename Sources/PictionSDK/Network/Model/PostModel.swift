//
//  PostModel.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias PostViewResponse = PostModel

public struct PostModel: Response {
    public let content: String?
    public let cover: String?
    public let createdAt: Date?
    public let id: Int?
    public let like: Bool?
    public let likeCount: Int?
    public let requiredSubscription: Bool?
    public let series: SeriesModel?
    public let title: String?

    public init(map: Mapper) throws {
        content = map.optionalFrom("content")
        cover = map.optionalFrom("cover")
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        like = map.optionalFrom("like")
        likeCount = map.optionalFrom("likeCount")
        requiredSubscription = map.optionalFrom("requiredSubscription")
        series = map.optionalFrom("series")
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
            "like": like,
            "likeCount": likeCount,
            "requiredSubscription": requiredSubscription,
            "series": series?.toDict(),
            "title": title,
        ]
    }
}

extension PostModel {
    static func sampleData() -> [String: Any] {
        return [
            "content": "content",
            "cover": "string",
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "id": 0,
            "like": false,
            "likeCount": 0,
            "requiredSubscription": true,
            "series": SeriesModel.sampleData(),
            "title": "title"
        ]
    }
}

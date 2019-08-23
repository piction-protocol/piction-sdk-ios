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
    public let cover: String?
    public let publishedAt: Date?
    public let createdAt: Date?
    public let fanPass: FanPassModel?
    public let id: Int?
    public let likeCount: Int?
    public let series: SeriesModel?
    public let title: String?
    public let status: String?

    public init(map: Mapper) throws {
        cover = map.optionalFrom("cover")
        publishedAt = map.optionalFrom("publishedAt")
        createdAt = map.optionalFrom("createdAt")
        fanPass = map.optionalFrom("fanPass")
        id = map.optionalFrom("id")
        likeCount = map.optionalFrom("likeCount")
        series = map.optionalFrom("series")
        title = map.optionalFrom("title")
        status = map.optionalFrom("status")
    }

    public func toJSONString() throws -> String {
         return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "cover": cover,
            "publishedAt": publishedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "fanPass": fanPass?.toDict(),
            "id": id,
            "likeCount": likeCount,
            "series": series?.toDict(),
            "title": title,
            "status": status
        ]
    }
}

extension PostModel {
    static func sampleData() -> [String: Any] {
        return [
            "cover": "string",
            "publishedAt": "2019-06-20T09:27:53.127+0000",
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "fanPass": FanPassModel.sampleData(),
            "id": 0,
            "likeCount": 0,
            "series": SeriesModel.sampleData(),
            "title": "title",
            "status": "PUBLIC"
        ]
    }
}

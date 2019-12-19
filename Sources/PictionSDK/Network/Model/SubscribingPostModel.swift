//
//  SubscribingPostModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/12/19.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias SubscribingPostViewResponse = SubscribingPostModel

public struct SubscribingPostModel: Response {
    public let id: Int?
    public let title: String?
    public let cover: String?
    public let likeCount: Int?
    public let series: SeriesModel?
    public let publishedAt: Date?
    public let createdAt: Date?
    public let fanPass: FanPassModel?
    public let status: String?
    public let project: ProjectModel?

    public init(map: Mapper) throws {
        id = map.optionalFrom("id")
        title = map.optionalFrom("title")
        cover = map.optionalFrom("cover")
        likeCount = map.optionalFrom("likeCount")
        series = map.optionalFrom("series")
        publishedAt = map.optionalFrom("publishedAt")
        createdAt = map.optionalFrom("createdAt")
        fanPass = map.optionalFrom("fanPass")
        status = map.optionalFrom("status")
        project = map.optionalFrom("project")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "id": id,
            "title": title,
            "cover": cover,
            "likeCount": likeCount,
            "series": series?.toDict(),
            "publishedAt": publishedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "fanPass": fanPass?.toDict(),
            "status": status,
            "project": project?.toDict()
        ]
    }
}

extension SubscribingPostModel {
    static func sampleData() -> [String: Any] {
        return [
            "id": 0,
            "title": "title",
            "cover": "",
            "likeCount": 0,
            "series": SeriesModel.sampleData(),
            "publishedAt": "2019-06-20T09:27:53.127+0000",
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "fanPass": FanPassModel.sampleData(),
            "status": "PUBLIC",
            "project": ProjectModel.sampleData()
        ]
    }
}

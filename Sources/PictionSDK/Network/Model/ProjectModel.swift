//
//  ProjectModel.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias ProjectViewResponse = ProjectModel

public struct ProjectModel: Response {
    public let adult: Bool?
    public let createdAt: Date?
    public let id: Int?
    public let lastPublishedAt: Date?
    public let status: String?
    public let subscriptionUserCount: Int?
    public let synopsis: String?
    public let tags: [String]?
    public let thumbnail: String?
    public let title: String?
    public let uri: String?
    public let user: UserModel?
    public let wideThumbnail: String?
    public let activeFanPass: Bool?
    public let categories: [CategoryModel]?

    public init(map: Mapper) throws {
        adult = map.optionalFrom("adult")
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        lastPublishedAt = map.optionalFrom("lastPublishedAt")
        status = map.optionalFrom("status")
        subscriptionUserCount = map.optionalFrom("subscriptionUserCount")
        synopsis = map.optionalFrom("synopsis")
        tags = map.optionalFrom("tags")
        thumbnail = map.optionalFrom("thumbnail")
        title = map.optionalFrom("title")
        uri = map.optionalFrom("uri")
        user = map.optionalFrom("user")
        wideThumbnail = map.optionalFrom("wideThumbnail")
        activeFanPass = map.optionalFrom("activeFanPass")
        categories = map.optionalFrom("categories")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "adult": adult,
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "lastPublishedAt": lastPublishedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "status": status,
            "subscriptionUserCount": subscriptionUserCount,
            "synopsis": synopsis,
            "tags": [],
            "thumbnail": thumbnail,
            "title": title,
            "uri": uri,
            "user": user?.toDict(),
            "wideThumbnail": wideThumbnail,
            "activeFanPass": activeFanPass,
            "categories": []
        ]
    }
}

extension ProjectModel {
    static func sampleData() -> [String: Any] {
        return [
            "adult": false,
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "id": 1,
            "lastPublishedAt": "2019-06-20T09:27:53.127+0000",
            "status": "PUBLIC",
            "subscriptionUserCount": 0,
            "synopsis": "synopsis",
            "tags": ["테스트", "프로젝트"],
            "thumbnail": "thumbnail",
            "title": "title",
            "url": "url",
            "user": UserModel.sampleData(),
            "wideThumbnail": "wideThumbnail",
            "activeFanPass": false,
            "categories": [CategoryModel.sampleData()]
        ]
    }
}


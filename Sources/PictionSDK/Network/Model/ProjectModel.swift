//
//  ProjectModel.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias ProjectViewResponse = ProjectModel

public struct ProjectModel: Response {
    public let createdAt: String?
    public let id: String?
    public let lastPublishedAt: String?
    public let subscriptionPrice: Int?
    public let synopsis: String?
    public let thumbnail: String?
    public let title: String?
    public let uri: String?
    public let user: UserModel?
    public let wideThumbnail: String?

    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        id = map.optionalFrom("id")
        lastPublishedAt = map.optionalFrom("lastPublishedAt")
        subscriptionPrice = map.optionalFrom("subscriptionPrice")
        synopsis = map.optionalFrom("synopsis")
        thumbnail = map.optionalFrom("thumbnail")
        title = map.optionalFrom("title")
        uri = map.optionalFrom("uri")
        user = map.optionalFrom("user")
        wideThumbnail = map.optionalFrom("wideThumbnail")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "createdAt": createdAt,
            "id": id,
            "lastPublishedAt": lastPublishedAt,
            "subscriptionPrice": subscriptionPrice,
            "synopsis": synopsis,
            "thumbnail": thumbnail,
            "title": title,
            "uri": uri,
            "user": user?.toDict(),
            "wideThumbnail": wideThumbnail
        ]
    }
}

extension ProjectModel {
    static func sampleData() -> [String: Any] {
        return [
            "createdAt": "2019-06-20T09:27:53.127+0000",
            "id": "id",
            "lastPublishedAt": "2019-06-20T09:27:53.127+0000",
            "subscriptionPrice": 0,
            "synopsis": "synopsis",
            "thumbnail": "thumbnail",
            "title": "title",
            "url": "url",
            "user": UserModel.sampleData(),
            "wideThumbnail": "wideThumbnail"
        ]
    }
}


//
//  ProjectResponse.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct ProjectResponse: Mappable {
    public let created_at: String?
    public let id: String?
    public let raw: String?
    public let synopsis: String?
    public let title: String?
    public let updated_at: String?

    public init(map: Mapper) throws {
        created_at = map.optionalFrom("created_at")
        id = map.optionalFrom("id")
        raw = map.optionalFrom("raw")
        synopsis = map.optionalFrom("synopsis")
        title = map.optionalFrom("title")
        updated_at = map.optionalFrom("updated_at")
    }
}

extension ProjectResponse {
    static func sampleData() -> [String: Any] {
        return [
            "created_at": "created_at",
            "id": "id",
            "raw": "raw",
            "synopsis": "synopsis",
            "title": "title",
            "updated_at": "updated_at",
        ]
    }
}


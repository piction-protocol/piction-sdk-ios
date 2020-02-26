//
//  CreatorProfileModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/02/19.
//  Copyright © 2020 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias CreatorProfileViewResponse = CreatorProfileModel

public struct CreatorProfileModel: Response {
    public let greetings: String?
    public let id: Int?
    public let links: [CreatorLinkModel]?

    public init(map: Mapper) throws {
        greetings = map.optionalFrom("greetings")
        id = map.optionalFrom("id")
        links = map.optionalFrom("links")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "greetings": greetings,
            "id": id,
            "links": links
        ]
    }
}

extension CreatorProfileModel {
    static func sampleData() -> [String: Any] {
        return [
            "greetings": "소개",
            "id": "0",
            "links": [CreatorLinkModel.sampleData()]
        ]
    }
}

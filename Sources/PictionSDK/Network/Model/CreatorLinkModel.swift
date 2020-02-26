//
//  CreatorLinkModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/02/19.
//  Copyright © 2020 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias CreatorLinkViewResponse = CreatorLinkModel

public struct CreatorLinkModel: Response {
    public let id: Int?
    public let name: String?
    public let url: String?

    public init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        url = map.optionalFrom("url")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "id": id,
            "name": name,
            "url": url
        ]
    }
}

extension CreatorLinkModel {
    static func sampleData() -> [String: Any] {
        return [
            "id": "0",
            "name": "인스타",
            "url": "https://piction.network"
        ]
    }
}

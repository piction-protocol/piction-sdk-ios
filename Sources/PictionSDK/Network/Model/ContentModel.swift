//
//  ContentModel.swift
//  PictionSDK
//
//  Created by jhseo on 04/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias ContentViewResponse = ContentModel

public struct ContentModel: Response {
    public let content: Bool?

    public init(map: Mapper) throws {
        content = map.optionalFrom("content")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "content": content
        ]
    }
}

extension ContentModel {
    static func sampleData() -> [String: Any] {
        return [
            "content": "content"
        ]
    }
}

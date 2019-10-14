//
//  PostIndexModel.swift
//  PictionSDK
//
//  Created by jhseo on 16/09/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias PostIndexViewResponse = PostIndexModel

public struct PostIndexModel: Response {
    public let index: Int?
    public let post: PostModel?

    public init(map: Mapper) throws {
        index = map.optionalFrom("index")
        post = map.optionalFrom("post")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "index": index,
            "post": post
        ]
    }
}

extension PostIndexModel {
    static func sampleData() -> [String: Any] {
        return [
            "index": "3",
            "post": PostModel.sampleData()
        ]
    }
}

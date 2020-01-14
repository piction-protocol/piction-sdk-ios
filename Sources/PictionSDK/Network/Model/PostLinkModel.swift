//
//  PostLinkModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias PostLinkViewResponse = PostLinkModel

public struct PostLinkModel: Response {
    public let nextPost: PostModel?
    public let previousPost: PostModel?

    public init(map: Mapper) throws {
        nextPost = map.optionalFrom("nextPost")
        previousPost = map.optionalFrom("previousPost")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "nextPost": nextPost?.toDict(),
            "previousPost": previousPost?.toDict()
        ]
    }
}

extension PostLinkModel {
    static func sampleData() -> [String: Any] {
        return [
            "nextPost": PostModel.sampleData(),
            "previousPost": PostModel.sampleData()
        ]
    }
}

//
//  LikeModel.swift
//  PictionSDK
//
//  Created by jhseo on 04/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias LikeViewResponse = LikeModel

public struct LikeModel: Response {
    public let like: Bool?

    public init(map: Mapper) throws {
        like = map.optionalFrom("like")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "like": like
        ]
    }
}

extension LikeModel {
    static func sampleData() -> [String: Any] {
        return [
            "like": false
        ]
    }
}

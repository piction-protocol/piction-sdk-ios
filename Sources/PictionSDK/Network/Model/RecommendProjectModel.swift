//
//  RecommendProjectModel.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias RecommendProjectViewResponse = RecommendProjectModel

public struct RecommendProjectModel: Response {
    public let project: ProjectModel?
    public let subscriptionCount: Int?

    public init(map: Mapper) throws {
        project = map.optionalFrom("project")
        subscriptionCount = map.optionalFrom("subscriptionCount")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "project": project?.toDict(),
            "subscriptionCount": subscriptionCount
        ]
    }
}

extension RecommendProjectModel {
    static func sampleData() -> [String: Any] {
        return [
            "project": ProjectModel.sampleData(),
            "subscriptionCount": 0
        ]
    }
}

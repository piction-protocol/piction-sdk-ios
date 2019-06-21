//
//  DefaultModel.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias DefaultViewResponse = DefaultModel

public struct DefaultModel: Response {
    public init(map: Mapper) throws {}

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [:]
    }
}

extension DefaultModel {
    static func sampleData() -> [String: Any] {
        return [:]
    }
}

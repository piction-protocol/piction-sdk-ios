//
//  FeesModel.swift
//  PictionSDK
//
//  Created by jhseo on 2019/11/21.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias FeesViewResponse = FeesModel

public struct FeesModel: Response {
    public let contentsDistributorRate: Int?
    public let userAdoptionPoolRate: Int?
    public let depositPoolRate: Int?
    public let ecosystemFundRate: Int?
    public let supportPoolRate: Int?
    public let translatorRate: Int?
    public let maketerRate: Int?

    public init(map: Mapper) throws {
        contentsDistributorRate = map.optionalFrom("contentsDistributorRate")
        userAdoptionPoolRate = map.optionalFrom("userAdoptionPoolRate")
        depositPoolRate = map.optionalFrom("depositPoolRate")
        ecosystemFundRate = map.optionalFrom("ecosystemFundRate")
        supportPoolRate = map.optionalFrom("supportPoolRate")
        translatorRate = map.optionalFrom("translatorRate")
        maketerRate = map.optionalFrom("maketerRate")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "contentsDistributorRate": contentsDistributorRate,
            "userAdoptionPoolRate": userAdoptionPoolRate,
            "depositPoolRate": depositPoolRate,
            "ecosystemFundRate": ecosystemFundRate,
            "supportPoolRate": supportPoolRate,
            "translatorRate": translatorRate,
            "maketerRate": maketerRate
        ]
    }
}

extension FeesModel {
    static func sampleData() -> [String: Any] {
        return [
            "contentsDistributorRate": 0,
            "userAdoptionPoolRate": 0,
            "depositPoolRate": 0,
            "ecosystemFundRate": 0,
            "supportPoolRate": 0,
            "translatorRate": 0,
            "maketerRate": 0
        ]
    }
}

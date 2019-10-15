//
//  SalesModel.swift
//  PictionSDK
//
//  Created by jhseo on 20/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SalesViewResponse = SalesModel

public struct SalesModel: Response {
    public let date: Date?
    public let amount: Double?

    public init(map: Mapper) throws {
        date = map.optionalFrom("date")
        amount = map.optionalFrom("amount")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "date": date?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "amount": amount
        ]
    }
}

extension SalesModel {
    static func sampleData() -> [String: Any] {
        return [
            "date": "2019-06-14T02:35:06.346Z",
            "amount": 0
        ]
    }
}

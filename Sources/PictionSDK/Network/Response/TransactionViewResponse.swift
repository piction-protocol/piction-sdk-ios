//
//  TransactionViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 12/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias TransactionModel = TransactionViewResponse

public struct TransactionViewResponse: Response {
    public let amount: Int?
    public let createdAt: String?
    public let inOut: String?
    public let status: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        createdAt = map.optionalFrom("createdAt")
        inOut = map.optionalFrom("inOut")
        status = map.optionalFrom("status")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "createdAt": createdAt,
            "inOut": inOut,
            "status": status
        ]
    }
}

extension TransactionViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 1000000000000000,
            "createdAt": "2019-06-13T01:23:04.540Z",
            "inOut": "IN",
            "status": "SUCCESS"
        ]
    }
}

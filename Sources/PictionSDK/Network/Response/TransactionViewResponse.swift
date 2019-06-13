//
//  TransactionViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 12/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public typealias TransactionModel = TransactionViewResponse

public struct TransactionViewResponse: Mappable {
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
}

extension TransactionViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "createdAt": "2019-06-13T01:23:04.540Z",
            "inOut": "string",
            "status": "string"
        ]
    }
}

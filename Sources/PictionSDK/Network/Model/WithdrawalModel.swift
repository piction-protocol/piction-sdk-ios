//
//  WithdrawalModel.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper
import Foundation

public typealias WithdrawalViewResponse = WithdrawalModel

public struct WithdrawalModel: Response {
    public let amount: Int?
    public let createAt: Date?
    public let id: Int?
    public let status: String?
    public let toAddress: String?
    public let user: UserModel?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        createAt = map.optionalFrom("createAt")
        id = map.optionalFrom("id")
        status = map.optionalFrom("status")
        toAddress = map.optionalFrom("toAddress")
        user = map.optionalFrom("user")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "createAt": createAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "status": status,
            "toAddress": toAddress,
            "user": user?.toDict()
        ]
    }
}

extension WithdrawalModel {
    static func sampleData() -> [String: Any] {
        return [
            "amount": 0,
            "createAt": "2019-06-20T09:27:53.127+0000",
            "id": 1,
            "status": "SUCCESS",
            "toAddress": "0xsljkjfiejwoief",
            "user": UserModel.sampleData()
        ]
    }
}

//
//  TransactionModel.swift
//  PictionSDK
//
//  Created by jhseo on 12/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias TransactionViewResponse = TransactionModel

public struct TransactionModel: Response {
    public let amount: Int?
    public let amountOriginal: String?
    public let blockNumber: Int?
    public let blockTime: Date?
    public let createdAt: Date?
    public let detailEndPoint: String?
    public let fromAddress: String?
    public let toAddress: String?
    public let inOut: String?
    public let transactionHash: String?
    public let transactionType: String?
    public let txHashWithUrl: String?

    public init(map: Mapper) throws {
        amount = map.optionalFrom("amount")
        amountOriginal = map.optionalFrom("amountOriginal")
        blockNumber = map.optionalFrom("blockNumber")
        blockTime = map.optionalFrom("blockTime")
        createdAt = map.optionalFrom("createdAt")
        detailEndPoint = map.optionalFrom("detailEndPoint")
        fromAddress = map.optionalFrom("fromAddress")
        toAddress = map.optionalFrom("toAddress")
        inOut = map.optionalFrom("inOut")
        transactionHash = map.optionalFrom("transactionHash")
        transactionType = map.optionalFrom("transactionType")
        txHashWithUrl = map.optionalFrom("txHashWithUrl")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "amount": amount,
            "amountOriginal": amountOriginal,
            "blockNumber": blockNumber,
            "blockTime": blockTime?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "createdAt": createdAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "detailEndPoint": detailEndPoint,
            "fromAddress": fromAddress,
            "toAddress": toAddress,
            "inOut": inOut,
            "transactionHash": transactionHash,
            "transactionType": transactionType,
            "txHashWithUrl": txHashWithUrl
        ]
    }
}

extension TransactionModel {
    static func sampleData() -> [String: Any] {
        return [
            "inOut": "IN",
            "transactionHash": "0x6a675b726a07b117eef....03f9b6723bb47455ab697c7caea9",
            "transactionType": "SPONSORSHIP",
            "txHashWithUrl": "",
            "detailEndPoint": "",
            "fromAddress": "0xf2f61a03bb....d5d97fa36897d66010bce",
            "toAddress": "0xfcff5beaf97....892a0581eca7f0d5aa3",
            "amount": 1,
            "amountOriginal": "1.000000000000000000 PXL",
            "blockNumber": 4724969,
            "blockTime": 1566269739000,
            "createdAt": 1566789723859
        ]
    }
}

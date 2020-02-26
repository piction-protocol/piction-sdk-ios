//
//  SponsorshipModel.swift
//  PictionSDK
//
//  Created by jhseo on 20/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias SponsorshipViewResponse = SponsorshipModel

public struct SponsorshipModel: Response {
    public let cpRevenue: Int?
    public let creator: UserModel?
    public let expireDate: Date?
    public let membership: MembershipModel?
    public let orderNo: Int?
    public let sponsor: UserModel?
    public let createAt: Date?
    public let paidPrice: Int?
    public let startedAt: Date?
    public let transactionStatus: String?

    public init(map: Mapper) throws {
        cpRevenue = map.optionalFrom("cpRevenue")
        creator = map.optionalFrom("creator")
        expireDate = map.optionalFrom("expireDate")
        membership = map.optionalFrom("membership")
        orderNo = map.optionalFrom("orderNo")
        sponsor = map.optionalFrom("sponsor")
        createAt = map.optionalFrom("createAt")
        paidPrice = map.optionalFrom("paidPrice")
        startedAt = map.optionalFrom("startedAt")
        transactionStatus = map.optionalFrom("transactionStatus")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "cpRevenue": cpRevenue,
            "creator": creator,
            "expireDate": expireDate?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "membership": membership,
            "orderNo": orderNo,
            "sponsor": sponsor,
            "createAt": createAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "paidPrice": paidPrice,
            "startedAt": startedAt?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "transactionStatus": transactionStatus,
        ]
    }
}

extension SponsorshipModel {
    static func sampleData() -> [String: Any] {
        return [
            "cpRevenue": 0,
            "creator": UserModel.sampleData(),
            "expireDate": "2019-06-20T09:27:53.127+0000",
            "membership": MembershipModel.sampleData(),
            "orderNo": 0,
            "sponsor": UserModel.sampleData(),
            "createAt": "2019-06-20T09:27:53.127+0000",
            "paidPrice": 0,
            "startedAt": "2019-06-20T09:27:53.127+0000",
            "transactionStatus": "SUCCESS",
        ]
    }
}

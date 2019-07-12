//
//  BannerModel.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

public typealias BannerViewResponse = BannerModel

public struct BannerModel: Response {
    public let availableAfter: Date?
    public let availableUntil: Date?
    public let id: Int?
    public let image: String?
    public let link: String?
    public let placements: String?
    public let priority: Int?
    public let status: Bool?
    public let title: String?

    public init(map: Mapper) throws {
        availableAfter = map.optionalFrom("availableAfter")
        availableUntil = map.optionalFrom("availableUntil")
        id = map.optionalFrom("id")
        image = map.optionalFrom("image")
        link = map.optionalFrom("link")
        placements = map.optionalFrom("placements")
        priority = map.optionalFrom("priority")
        status = map.optionalFrom("status")
        title = map.optionalFrom("title")
    }

    public func toJSONString() throws -> String {
        return try! toJSON(dict: self.toDict())
    }

    public func toDict() -> [String: Any?] {
        return [
            "availableAfter": availableAfter?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "availableUntil": availableUntil?.toString(format: "YYYY-MM-dd'T'HH:mm:ssZ"),
            "id": id,
            "image": image,
            "link": link,
            "placements": placements,
            "priority": priority,
            "status": status,
            "title": title
        ]
    }
}

extension BannerModel {
    static func sampleData() -> [String: Any] {
        return [
            "availableAfter": "2019-07-10T08:51:40.935Z",
            "availableUntil": "2019-07-12T08:51:40.935Z",
            "id": 0,
            "image": "",
            "link": "https://piction.network",
            "placements": "NOTICE",
            "priority": 0,
            "status": true,
            "title": "공지"
        ]
    }
}

//
//  StorageAttachmentViewResponse.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct StorageAttachmentViewResponse: Mappable {
    public let filename: String?
    public let id: String?
    public let url: String?

    public init(map: Mapper) throws {
        filename = map.optionalFrom("filename")
        id = map.optionalFrom("id")
        url = map.optionalFrom("url")
    }
}

extension StorageAttachmentViewResponse {
    static func sampleData() -> [String: Any] {
        return [
            "filename": "1560307278891.png",
            "id": "782db35206a2a396b31abbab2c9a0b45",
            "url": "https://cdn.piction.network/user/picture/1560307278891.png"
        ]
    }
}

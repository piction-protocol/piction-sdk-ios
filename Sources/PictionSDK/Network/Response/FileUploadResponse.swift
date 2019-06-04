//
//  FileUploadResponse.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct FileUploadResponse: Mappable {
    public let filename: String?
    public let url: String?

    public init(map: Mapper) throws {
        filename = map.optionalFrom("filename")
        url = map.optionalFrom("url")
    }
}

extension FileUploadResponse {
    static func sampleData() -> [String: Any] {
        return [
            "filename": "filename",
            "url": "4200deeba2bde9aea76e4d1842a43c0a0eca2f8b"
        ]
    }
}

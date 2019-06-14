//
//  DefaultResponse.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct DefaultResponse: Mappable {
    public init(map: Mapper) throws {}
}

extension DefaultResponse {
    static func sampleData() -> [String: Any] {
        return [:]
    }
}

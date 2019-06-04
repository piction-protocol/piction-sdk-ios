//
//  TargetTypeExtension.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    func jsonSerializedUTF8(json: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }

    func jsonSerializedUTF8(json: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}

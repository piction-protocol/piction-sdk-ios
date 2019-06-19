//
//  JsonUtil.swift
//  Piction-SDK-iOS-Example
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonUtil {
    static func toString(dict: [[String: Any?]]) -> String? {
        let json = JSON(dict)
        return json.rawString(.utf8, options: .prettyPrinted)
    }

    static func toString(dict: [String: Any?]) -> String? {
        let json = JSON(dict)
        return json.rawString(.utf8, options: .prettyPrinted)
    }
}

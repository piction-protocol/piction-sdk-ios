//
//  DateExtension.swift
//  PictionSDK
//
//  Created by jhseo on 21/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper

extension Date {
   func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date: Convertible {
    public static func fromMap(_ value: Any) throws -> Date {
        guard let timeInterval = value as? TimeInterval else {
            throw MapperError.convertibleError(value: value, type: Date.self)
        }

        return Date(timeIntervalSince1970: timeInterval / 1000)
    }
}

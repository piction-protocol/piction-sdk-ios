//
//  ErrorType.swift
//  PictionSDK
//
//  Created by jhseo on 23/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public enum ErrorType: Error {
    case unauthorized(_ error: ErrorModel)
    case forbidden(_ error: ErrorModel)
    case notFound(_ error: ErrorModel)
    case unknown(_ error: ErrorModel)
}

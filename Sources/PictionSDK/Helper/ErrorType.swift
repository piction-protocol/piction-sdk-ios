//
//  ErrorType.swift
//  PictionSDK
//
//  Created by jhseo on 23/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum ErrorType: Error {
    case badRequest(_ error: ErrorModel)
    case unauthorized(_ error: ErrorModel)
    case forbidden(_ error: ErrorModel)
    case notFound(_ error: ErrorModel)
    case gatewayTimeout(_ error: Moya.Response)
    case unknown(_ error: Moya.Response)
}

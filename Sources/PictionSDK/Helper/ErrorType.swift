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
    case payloadTooLarge(_ error: Moya.Response)
    case internalServerError(_ error: ErrorModel)
    case gatewayTimeout(_ error: Moya.Response)
    case unknown(_ error: Moya.Response)
    case custom(_ error: ErrorModel)

    public var message: String {
        switch self {
        case .badRequest(let error),
             .unauthorized(let error),
             .forbidden(let error),
             .notFound(let error),
             .internalServerError(let error),
             .custom(let error):
             return error.message ?? ""
        case .gatewayTimeout(let error),
             .unknown(let error),
            .payloadTooLarge(let error):
            return error.description
        }
    }
}

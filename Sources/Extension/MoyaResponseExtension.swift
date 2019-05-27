//
//  MoyaResponseExtension.swift
//  PictionSDK
//
//  Created by jhseo on 23/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Mapper
import Moya
import Moya_ModelMapper

extension Moya.Response {
    func filterStatusCode<M: Mappable>() throws -> M {
        guard 200 ... 399 ~= self.statusCode else {
            let errorItem = try self.map(to: ErrorModel.self)

            switch self.statusCode {
            case 401:
                throw ErrorType.unauthorized(errorItem)
            case 403:
                throw ErrorType.forbidden(errorItem)
            case 404:
                throw ErrorType.notFound(errorItem)
            default:
                throw ErrorType.unknown(errorItem)
            }
        }
        return try self.map(to: M.self)
    }
}

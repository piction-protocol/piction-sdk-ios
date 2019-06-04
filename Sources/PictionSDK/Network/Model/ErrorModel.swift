//
//  ErrorModel.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Mapper

public struct ErrorModel: Mappable {
    public let code: Int?
    public let status_code: String?
    public let message: String?

    public init(map: Mapper) throws {
        code = map.optionalFrom("code")
        status_code = map.optionalFrom("status_code")
        message = map.optionalFrom("message")
    }
}

extension ErrorModel {
    static func sampleData() -> [String: Any] {
        return [
            "code": "9999",
            "status_code": "INTERNAL_SERVER_ERROR",
            "message": "서버가 응답하지 않습니다. 잠시 후 다시 시도해주세요"
        ]
    }
}

//public enum SignupErrors {
//    case E_4000
//    case E_4001
//    case E_4002
//    case E_4003
//    case E_4004
//    case E_4005
//    case E_4006
//
//    public var
//}

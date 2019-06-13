//
//  SessionsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum SessionsAPI {
    case create(email: String, password: String)
}

extension SessionsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .create:
            return "/sessions"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .create:
            return .post
        }
    }
    public var sampleData: Data {
        switch self {
        case .create:
            return jsonSerializedUTF8(json: AuthenticationViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let email, let password):
            let param = [
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

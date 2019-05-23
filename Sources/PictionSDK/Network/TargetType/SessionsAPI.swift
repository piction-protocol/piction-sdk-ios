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
    case create(username: String, password: String)
}

extension SessionsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .create(_):
            return "/sessions"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .create(_):
            return .post
        }
    }
    public var sampleData: Data {
        switch self {
        case .create(_):
            return jsonSerializedUTF8(json: AuthenticationResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let username, let password):
            let param = [
                "username": username,
                "password": password
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

//
//  SessionAPI.swift
//  PictionSDK
//
//  Created by jhseo on 20/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum SessionAPI {
    case create(loginId: String, password: String, rememberme: Bool)
    case delete
}

extension SessionAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .create,
             .delete:
            return "/sessions"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .delete:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .create,
             .delete:
            return jsonSerializedUTF8(json: AuthenticationViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let loginId, let password, let rememberme):
            var param: [String: Any] = [:]
            param["loginId"] = loginId
            param["password"] = password
            param["rememberme"] = rememberme
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .delete:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

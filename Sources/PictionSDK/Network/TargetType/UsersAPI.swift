//
//  UsersAPI.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum UsersAPI {
    case signup(email: String, username: String, password: String, confirmPassword: String)
    case me
}

extension UsersAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .signup(_):
            return "/users"
        case .me:
            return "/users/me"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signup(_):
            return .post
        case .me:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .signup(_):
            return jsonSerializedUTF8(json: AuthenticationResponse.sampleData())
        case .me:
            return jsonSerializedUTF8(json: CurrentUserResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .signup(let email, let username, let password, let confirmPassword):
            let param = [
                "email": email,
                "username": username,
                "password": password,
                "confirmPassword": confirmPassword
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .me:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

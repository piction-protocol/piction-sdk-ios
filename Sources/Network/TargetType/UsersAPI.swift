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
    case update(email: String, username: String, password: String, picture: String)
    case updatePassword(password: String, newPassword: String, confirmPassword: String)
}

extension UsersAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .signup(_):
            return "/users"
        case .me,
             .update(_):
            return "/users/me"
        case .updatePassword:
            return "/users/me/password"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signup(_):
            return .post
        case .me:
            return .get
        case .update(_):
            return .put
        case .updatePassword:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .signup(_),
             .updatePassword(_):
            return jsonSerializedUTF8(json: AuthenticationResponse.sampleData())
        case .me:
            return jsonSerializedUTF8(json: CurrentUserResponse.sampleData())
        case .update(_):
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
        case .update(let email, let username, let password, let picture):
            let param = [
                "email": email,
                "username": username,
                "password": password,
                "picture": picture
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .updatePassword(let password, let newPassword, let confirmPassword):
            let param = [
                "password": password,
                "newPassword": newPassword,
                "confirmPassword": confirmPassword
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

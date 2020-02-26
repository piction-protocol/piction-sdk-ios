//
//  UserAPI.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum UserAPI {
    case signup(loginId: String, email: String, username: String, password: String, passwordCheck: String)
    case findOne(id: String)
    case me
    case update(email: String, username: String, password: String, picture: String? = nil)
    case updatePassword(password: String, newPassword: String, passwordCheck: String)
    case uploadPicture(image: UIImage)
    case findPublicAddress(address: String)
}

extension UserAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .signup:
            return "/users"
        case .findOne(let id):
            return "/users/\(id)"
        case .me,
             .update:
            return "/users/me"
        case .updatePassword:
            return "/users/me/password"
        case .uploadPicture:
            return "/users/me/picture"
        case .findPublicAddress(let address):
            return "/users/wallet/\(address)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        case .findOne,
             .me,
             .findPublicAddress:
            return .get
        case .update:
            return .put
        case .updatePassword,
             .uploadPicture:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .signup,
             .updatePassword:
            return jsonSerializedUTF8(json: AuthenticationViewResponse.sampleData())
        case .findOne,
             .update,
             .me,
             .findPublicAddress:
            return jsonSerializedUTF8(json: UserViewResponse.sampleData())
        case .uploadPicture:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .findOne,
             .me,
             .findPublicAddress:
            return .requestPlain
        case .signup(let loginId, let email, let username, let password, let passwordCheck):
            var param: [String: Any] = [:]
            param["loginId"] = loginId
            param["email"] = email
            param["username"] = username
            param["password"] = password
            param["passwordCheck"] = passwordCheck
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .update(let email, let username, let password, let picture):
            var param: [String: Any] = [:]
            param["email"] = email
            param["username"] = username
            param["password"] = password
            if let picture = picture {
                param["picture"] = picture
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .updatePassword(let password, let newPassword, let passwordCheck):
            var param: [String: Any] = [:]
            param["password"] = password
            param["newPassword"] = newPassword
            param["passwordCheck"] = passwordCheck
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .uploadPicture(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadPicture:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

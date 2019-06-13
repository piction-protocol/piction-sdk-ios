//
//  UsersAPI.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum UsersAPI {
    case signup(email: String, username: String, password: String)
    case me
    case update(email: String, username: String, password: String, picture: String?)
    case updatePassword(password: String, newPassword: String)
    case uploadPicture(image: UIImage)
    case transactions(page: Int, size: Int)
}

extension UsersAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .signup:
            return "/users"
        case .me,
             .update:
            return "/users/me"
        case .updatePassword:
            return "/users/me/password"
        case .uploadPicture:
            return "/users/me/picture"
        case .transactions:
            return "/users/me/transactions"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        case .me,
             .transactions:
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
        case .me:
            return jsonSerializedUTF8(json: UserViewResponse.sampleData())
        case .update:
            return jsonSerializedUTF8(json: UserViewResponse.sampleData())
        case .uploadPicture:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .transactions:
            return jsonSerializedUTF8(json: PageViewResponse<TransactionModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .signup(let email, let username, let password):
            let param = [
                "email": email,
                "username": username,
                "password": password
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
        case .updatePassword(let password, let newPassword):
            let param = [
                "password": password,
                "newPassword": newPassword
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .uploadPicture(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .transactions(let page, let size):
            let param = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
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

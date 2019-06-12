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
        case .signup(_):
            return "/users"
        case .me,
             .update(_):
            return "/users/me"
        case .updatePassword:
            return "/users/me/password"
        case .uploadPicture(_):
            return "/users/me/picture"
        case .transactions(let page, let size):
            return "/users/me/transactions?page=\(page)&size=\(size)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signup(_):
            return .post
        case .me,
             .transactions(_):
            return .get
        case .update(_):
            return .put
        case .updatePassword,
             .uploadPicture(_):
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .signup(_),
             .updatePassword(_):
            return jsonSerializedUTF8(json: AuthenticationViewResponse.sampleData())
        case .me:
            return jsonSerializedUTF8(json: UserViewResponse.sampleData())
        case .update(_):
            return jsonSerializedUTF8(json: UserViewResponse.sampleData())
        case .uploadPicture(_):
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .transactions(_):
            return jsonSerializedUTF8(json: TransactionViewResponse.sampleData())
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
        case .me,
             .transactions(_):
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
            let imageData = image.jpegData(compressionQuality: 1.0)
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "user_img", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadPicture(_):
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

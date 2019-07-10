//
//  ProjectsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum ProjectsAPI {
    case all
    case create(uri: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, subscriptionPrice: Int)
    case get(uri: String)
    case update(uri: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, subscriptionPrice: Int)
    case isSubscribing(uri: String)
    case subscription(uri: String, subscriptionPrice: Int)
    case search(name: String)
    case uploadThumbnail(image: UIImage)
    case uploadWideThumbnail(image: UIImage)
}

extension ProjectsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all,
             .create:
            return "/projects"
        case .get(let uri),
             .update(let uri, _, _, _, _, _):
            return "/projects/\(uri)"
        case .subscription(let uri, _),
             .isSubscribing(let uri):
            return "/projects/\(uri)/subscription"
        case .search:
            return "/projects/search"
        case .uploadThumbnail:
            return "/projects/thumbnail"
        case .uploadWideThumbnail:
            return "/projects/wide-thumbnail"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .isSubscribing,
             .search:
            return .get
        case .create,
             .subscription:
            return .post
        case .update:
            return .put
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .search:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        case .subscription,
             .isSubscribing:
            return jsonSerializedUTF8(json: SubscriptionViewResponse.sampleData())
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let uri, let title, let synopsis, let thumbnail, let wideThumbnail, let subscriptionPrice):
            let param: [String : Any] = [
                "uri": uri,
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail,
                "subscriptionPrice": subscriptionPrice
                ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .all,
             .get,
             .isSubscribing:
            return .requestPlain
        case .update(_, let title, let synopsis, let thumbnail, let wideThumbnail, let subscriptionPrice):
            let param: [String : Any] = [
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail,
                "subscriptionPrice": subscriptionPrice
                ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .subscription(_, let subscriptionPrice):
            let param = [
                "subscriptionPrice": subscriptionPrice
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .search(let name):
            let param = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .uploadThumbnail(let image),
             .uploadWideThumbnail(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

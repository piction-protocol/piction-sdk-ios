//
//  FanPassAPI.swift
//  PictionSDK
//
//  Created by jhseo on 06/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import Moya

public enum FanPassAPI {
    case get(fanPassId: Int)
    case update(fanPassId: Int, name: String, description: String, thumbnail: String, subscriptionLimit: Int, subscriptionPrice: Int, status: Bool)
    case isSubscription(uri: String)
    case subscription(fanPassId: Int, subscriptionPrice: Int)
    case delete(fanPassId: Int)
    case projectAll(uri: String)
    case create(uri: String, level: Int, name: String, description: String, thumbnail: String, subscriptionLimit: Int, subscriptionPrice: Int, status: Bool)
    case uploadThumbnail(image: UIImage)
}

extension FanPassAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .get(let fanPassId),
             .update(let fanPassId, _, _, _, _, _, _):
            return "/fan-pass/\(fanPassId)"
        case .isSubscription(let uri):
            return "/fan-pass/projects/\(uri)/subscription"
        case .subscription(let fanPassId, _),
             .delete(let fanPassId):
            return "/fan-pass/\(fanPassId)/subscription"
        case .projectAll(let uri),
             .create(let uri, _, _, _, _, _, _, _):
            return "/fan-pass/projects/\(uri)"
        case .uploadThumbnail:
            return "/fan-pass/thumbnail"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .get,
             .isSubscription,
             .projectAll:
            return .get
        case .update:
            return .put
        case .subscription,
             .create:
            return .post
        case .delete:
            return .delete
        case .uploadThumbnail:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .get,
             .update,
             .create:
            return jsonSerializedUTF8(json: FanPassViewResponse.sampleData())
        case .isSubscription,
             .subscription:
            return jsonSerializedUTF8(json: SubscriptionViewResponse.sampleData())
        case .delete:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .projectAll:
            return jsonSerializedUTF8(json: [FanPassViewResponse.sampleData()])
        case .uploadThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .get,
             .isSubscription,
             .delete,
             .projectAll:
            return .requestPlain
        case .update(_, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice, let status):
            var param: [String: Any] = [:]
            param["name"] = name
            param["description"] = description
            param["thumbnail"] = thumbnail
            param["subscriptionLimit"] = subscriptionLimit
            param["subscriptionPrice"] = subscriptionPrice
            param["status"] = status
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .subscription(_, let subscriptionPrice):
            let param: [String : Any] = [
                "subscriptionPrice": subscriptionPrice
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .create(_, let level, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice, let status):
            var param: [String: Any] = [:]
            param["level"] = level
            param["name"] = name
            param["description"] = description
            param["thumbnail"] = thumbnail
            param["subscriptionLimit"] = subscriptionLimit
            param["subscriptionPrice"] = subscriptionPrice
            param["status"] = status
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .uploadThumbnail(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadThumbnail:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

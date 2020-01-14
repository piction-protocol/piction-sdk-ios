//
//  FanPassAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum FanPassAPI {
    case all(uri: String)
    case create(uri: String, name: String, description: String? = nil, thumbnail: String? = nil, subscriptionLimit: Int? = nil, subscriptionPrice: Int? = nil)
    case get(uri: String, fanPassId: Int)
    case update(uri: String, fanPassId: Int, name: String, description: String? = nil, thumbnail: String? = nil, subscriptionLimit: Int? = nil, subscriptionPrice: Int? = nil)
    case delete(uri: String, fanPassId: Int)
    case subscription(uri: String, fanPassId: Int, subscriptionPrice: Int)
    case cancelSubscription(uri: String, fanPassId: Int)
    case getSubscribedFanPass(uri: String)
    case uploadThumbnail(image: UIImage)
}

extension FanPassAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let uri),
             .create(let uri, _, _, _, _, _):
            return "/projects/\(uri)/fan-passes"
        case .get(let uri, let fanPassId),
             .update(let uri, let fanPassId, _, _, _, _, _),
             .delete(let uri, let fanPassId):
            return "/projects/\(uri)/fan-passes/\(fanPassId)"
        case .subscription(let uri, let fanPassId, _),
             .cancelSubscription(let uri, let fanPassId):
            return "/projects/\(uri)/fan-passes/\(fanPassId)/subscription"
        case .getSubscribedFanPass(let uri):
            return "/projects/\(uri)/fan-passes/subscription"
        case .uploadThumbnail:
            return "/projects/fan-passes/thumbnail"
        }
    }
    public var method: Moya.Method {
        switch self {
       case  .all,
             .get,
             .getSubscribedFanPass:
            return .get
        case .create,
             .subscription:
            return .post
        case .update:
            return .put
        case .uploadThumbnail:
            return .patch
        case .delete,
             .cancelSubscription:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [FanPassViewResponse.sampleData()])
        case .get,
             .create,
             .update:
            return jsonSerializedUTF8(json: FanPassViewResponse.sampleData())
        case .uploadThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .delete,
             .cancelSubscription:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .subscription,
             .getSubscribedFanPass:
            return jsonSerializedUTF8(json: SubscriptionViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .get,
             .delete,
             .cancelSubscription,
             .getSubscribedFanPass:
            return .requestPlain
        case .uploadThumbnail(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .create(_, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice),
             .update(_, _, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice):
            var param: [String: Any] = [:]
            param["name"] = name
            param["subscriptionPrice"] = subscriptionPrice
            if let description = description {
                param["description"] = description
            }
            if let subscriptionLimit = subscriptionLimit {
                param["subscriptionLimit"] = subscriptionLimit
            }
            if let thumbnail = thumbnail {
                param["thumbnail"] = thumbnail
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .subscription(_, _, let subscriptionPrice):
            var param: [String: Any] = [:]
            param["subscriptionPrice"] = subscriptionPrice
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
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

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
    case all(page: Int, size: Int, tagName: String? = nil)
    case create(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String)
    case get(uri: String)
    case update(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String)
    case uploadThumbnail(image: UIImage)
    case uploadWideThumbnail(image: UIImage)
    case trending
    case fanPassAll(uri: String)
    case createFanPass(uri: String, name: String, description: String? = nil, thumbnail: String? = nil, subscriptionLimit: Int? = nil, subscriptionPrice: Int? = nil)
    case fanPass(uri: String, fanPassId: Int)
    case updateFanPass(uri: String, fanPassId: Int, name: String, description: String? = nil, thumbnail: String? = nil, subscriptionLimit: Int? = nil, subscriptionPrice: Int? = nil)
    case deleteFanPass(uri: String, fanPassId: Int)
    case subscription(uri: String, fanPassId: Int, subscriptionPrice: Int)
    case cancelSubscription(uri: String, fanPassId: Int)
    case getProjectSubscription(uri: String)
    case uploadFanPassThumbnail(image: UIImage)
    case fees(uri: String)
}

extension ProjectsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all,
             .create:
            return "/projects"
        case .get(let uri),
             .update(let uri, _, _, _, _, _, _):
            return "/projects/\(uri)"
        case .uploadThumbnail:
            return "/projects/thumbnail"
        case .uploadWideThumbnail:
            return "/projects/wide-thumbnail"
        case .trending:
            return "/projects/trending"
        case .fanPassAll(let uri),
             .createFanPass(let uri, _, _, _, _, _):
            return "/projects/\(uri)/fan-pass"
        case .fanPass(let uri, let fanPassId),
             .updateFanPass(let uri, let fanPassId, _, _, _, _, _),
             .deleteFanPass(let uri, let fanPassId):
            return "/projects/\(uri)/fan-pass/\(fanPassId)"
        case .subscription(let uri, let fanPassId, _),
             .cancelSubscription(let uri, let fanPassId):
            return "/projects/\(uri)/fan-pass/\(fanPassId)/subscription"
        case .getProjectSubscription(let uri):
            return "/projects/\(uri)/fan-pass/subscription"
        case .uploadFanPassThumbnail:
            return "/projects/fan-pass/thumbnail"
        case .fees(let uri):
            return "/projects/\(uri)/fees"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .trending,
             .fanPassAll,
             .fanPass,
             .getProjectSubscription,
             .fees:
            return .get
        case .create,
             .createFanPass,
             .subscription:
            return .post
        case .update,
             .updateFanPass:
            return .put
        case .uploadThumbnail,
             .uploadWideThumbnail,
             .uploadFanPassThumbnail:
            return .patch
        case .deleteFanPass,
             .cancelSubscription:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all,
             .trending:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .uploadThumbnail,
             .uploadWideThumbnail,
             .uploadFanPassThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .fanPassAll:
            return jsonSerializedUTF8(json: [FanPassViewResponse.sampleData()])
        case .createFanPass,
             .fanPass,
             .updateFanPass:
            return jsonSerializedUTF8(json: FanPassViewResponse.sampleData())
        case .deleteFanPass,
             .cancelSubscription:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .subscription,
             .getProjectSubscription:
            return jsonSerializedUTF8(json: SubscriptionViewResponse.sampleData())
        case .fees:
            return jsonSerializedUTF8(json: FeesViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let uri, let title, let synopsis, let thumbnail, let wideThumbnail, let tags, let status):
            var param: [String: Any] = [:]
            param["uri"] = uri
            param["title"] = title
            param["synopsis"] = synopsis
            param["status"] = status
            param["tags"] = tags
            if let thumbnail = thumbnail {
                param["thumbnail"] = thumbnail
            }
            if let wideThumbnail = wideThumbnail {
                param["wideThumbnail"] = wideThumbnail
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .all(let page, let size, let tagName):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            if let tagName = tagName {
                param["tagName"] = tagName
            }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .get,
             .trending,
             .fanPassAll,
             .fanPass,
             .deleteFanPass,
             .cancelSubscription,
             .getProjectSubscription,
             .fees:
            return .requestPlain
        case .update(_, let title, let synopsis, let thumbnail, let wideThumbnail, let tags, let status):
            var param: [String: Any] = [:]
            param["title"] = title
            param["synopsis"] = synopsis
            param["status"] = status
            param["tags"] = tags
            if let thumbnail = thumbnail {
                param["thumbnail"] = thumbnail
            }
            if let wideThumbnail = wideThumbnail {
                param["wideThumbnail"] = wideThumbnail
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .uploadThumbnail(let image),
             .uploadWideThumbnail(let image),
             .uploadFanPassThumbnail(let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .createFanPass(_, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice),
             .updateFanPass(_, _, let name, let description, let thumbnail, let subscriptionLimit, let subscriptionPrice):
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
        case .uploadThumbnail,
             .uploadWideThumbnail,
             .uploadFanPassThumbnail:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

//
//  ProjectAPI.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum ProjectAPI {
    case all(page: Int, size: Int)
    case create(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String)
    case get(uri: String)
    case update(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String)
    case uploadThumbnail(image: UIImage)
    case uploadWideThumbnail(image: UIImage)
    case trending
    case fees(uri: String)
}

extension ProjectAPI: TargetType {
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
        case .fees(let uri):
            return "/projects/\(uri)/fees"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .trending,
             .fees:
            return .get
        case .create:
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
        case .all,
             .trending:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
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
        case .all(let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .get,
             .trending,
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

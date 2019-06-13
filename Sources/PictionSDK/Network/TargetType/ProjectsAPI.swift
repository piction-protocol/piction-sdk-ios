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
    case create(uri: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String)
    case get(id: String)
    case update(id: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String)
    case uploadThumbnail(image: UIImage)
    case uploadWideThumbnail(image: UIImage)
}

extension ProjectsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all,
             .create(_):
            return "/projects"
        case .get(let id),
             .update(let id, _, _, _, _):
            return "/projects/\(id)"
        case .uploadThumbnail(_):
            return "/projects/thumbnail"
        case .uploadWideThumbnail(_):
            return "/projects/wide-thumbnail"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get(_):
            return .get
        case .create(_):
            return .post
        case .update(_):
            return .put
        case .uploadThumbnail(_),
             .uploadWideThumbnail(_):
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .create(_),
             .get(_),
             .update(_):
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .uploadThumbnail(_),
             .uploadWideThumbnail(_):
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let uri, let title, let synopsis, let thumbnail, let wideThumbnail):
            let param = [
                "uri": uri,
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .all,
             .get(_):
            return .requestPlain
        case .update(_, let title, let synopsis, let thumbnail, let wideThumbnail):
            let param = [
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail
            ]
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

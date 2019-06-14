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
    case get(projectId: String)
    case update(projectId: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String)
    case uploadThumbnail(image: UIImage)
    case uploadWideThumbnail(image: UIImage)
    case recommendedAll
    case recommendedAdd(projectId: String)
    case recommendedDelete(projectId: String)
}

extension ProjectsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all,
             .create:
            return "/projects"
        case .get(let projectId),
             .update(let projectId, _, _, _, _):
            return "/projects/\(projectId)"
        case .uploadThumbnail:
            return "/projects/thumbnail"
        case .uploadWideThumbnail:
            return "/projects/wide-thumbnail"
        case .recommendedAll:
            return "/recommended-projects"
        case .recommendedAdd(let projectId),
             .recommendedDelete(let projectId):
            return "/recommended-projects/\(projectId)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .recommendedAll:
            return .get
        case .create,
            .recommendedAdd:
            return .post
        case .update:
            return .put
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return .patch
        case .recommendedDelete:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all,
             .recommendedAll:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .uploadThumbnail,
             .uploadWideThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .recommendedAdd,
             .recommendedDelete:
            return jsonSerializedUTF8(json: DefaultResponse.sampleData())
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
             .get,
             .recommendedAll,
             .recommendedAdd,
             .recommendedDelete:
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

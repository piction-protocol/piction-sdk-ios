//
//  PostsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum PostsAPI {
    case all(projectId: String, page: Int, size: Int)
    case create(projectId: String, title: String, content: String, cover: String, status: String, membership: String, seriesId: String)
    case get(projectId: String, postId: String)
    case update(projectId: String, postId: String, title: String, content: String, cover: String, status: String, membership: String, seriesId: String)
    case uploadContentImage(projectId: String, image: UIImage)
    case uploadCoverImage(projectId: String, image: UIImage)
}

extension PostsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let projectId, _, _),
             .create(let projectId, _, _, _, _, _, _):
            return "/projects/\(projectId)/posts"
        case .get(let projectId, let postId),
             .update(let projectId, let postId, _, _, _, _, _, _):
            return "/projects/\(projectId)/posts/\(postId)"
        case .uploadContentImage(let projectId, _):
            return "/projects/\(projectId)/posts/content"
        case .uploadCoverImage(let projectId, _):
            return "/projects/\(projectId)/posts/cover"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .uploadContentImage,
             .uploadCoverImage:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        case .create(_),
             .get(_),
             .update(_):
            return jsonSerializedUTF8(json: PostViewResponse.sampleData())
        case .uploadContentImage(_),
             .uploadCoverImage(_):
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all(_, let page, let size):
            let param = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .create(_, let title, let content, let cover, let status, let membership, let seriesId),
             .update(_, _, let title, let content, let cover, let status, let membership, let seriesId):
            let param = [
                "title": title,
                "content": content,
                "cover": cover,
                "status": status,
                "membership": membership,
                "seriesId": seriesId
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .get:
            return .requestPlain
        case .uploadContentImage(_, let image),
             .uploadCoverImage(_, let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadContentImage,
             .uploadCoverImage:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}


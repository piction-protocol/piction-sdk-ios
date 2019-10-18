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
    case all(uri: String, isRequiredFanPass: Bool? = nil, page: Int, size: Int)
    case create(uri: String, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64)
    case get(uri: String, postId: Int)
    case update(uri: String, postId: Int, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64)
    case delete(uri: String, postId: Int)
    case content(uri: String, postId: Int)
    case isLike(uri: String, postId: Int)
    case like(uri: String, postId: Int)
    case prevPost(uri: String, postId: Int)
    case nextPost(uri: String, postId: Int)
    case uploadContentImage(uri: String, image: UIImage)
    case uploadCoverImage(uri: String, image: UIImage)
}

extension PostsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let uri, _, _, _),
             .create(let uri, _, _, _, _, _, _, _):
            return "/projects/\(uri)/posts"
        case .get(let uri, let postId),
             .update(let uri, let postId, _, _, _, _, _, _, _),
             .delete(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)"
        case .content(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)/content"
        case .isLike(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)/isLike"
        case .prevPost(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)/previous"
        case .nextPost(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)/next"
        case .uploadContentImage(let uri, _):
            return "/projects/\(uri)/posts/content"
        case .uploadCoverImage(let uri, _):
            return "/projects/\(uri)/posts/cover"
        case .like(let uri, let postId):
            return "/projects/\(uri)/posts/\(postId)/like"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .content,
             .isLike,
             .prevPost,
             .nextPost:
            return .get
        case .create,
             .like:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        case .uploadContentImage,
             .uploadCoverImage:
            return .patch
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        case .create,
             .get,
             .update,
             .like,
             .prevPost,
             .nextPost:
            return jsonSerializedUTF8(json: PostViewResponse.sampleData())
        case .delete:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .content:
            return jsonSerializedUTF8(json: ContentViewResponse.sampleData())
        case .isLike:
            return jsonSerializedUTF8(json: LikeViewResponse.sampleData())
        case .uploadContentImage,
             .uploadCoverImage:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all(_, let isRequiredFanPass, let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            if let isRequiredFanPass = isRequiredFanPass {
                param["isRequiredFanPass"] = isRequiredFanPass
            }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .create(_, let title, let content, let cover, let seriesId, let fanPassId, let status, let publishedAt),
             .update(_, _, let title, let content, let cover, let seriesId, let fanPassId, let status, let publishedAt):
            var param: [String: Any] = [:]
            param["title"] = title
            param["content"] = content
            param["cover"] = cover
            param["status"] = status
            param["publishedAt"] = publishedAt
            if seriesId != nil {
                param["seriesId"] = seriesId
            }
            if fanPassId != nil {
                param["fanPassId"] = fanPassId
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .get,
             .like,
             .delete,
             .content,
             .isLike,
             .prevPost,
             .nextPost:
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


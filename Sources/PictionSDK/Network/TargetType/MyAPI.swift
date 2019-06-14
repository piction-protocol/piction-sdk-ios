//
//  MyAPI.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum MyAPI {
    case getProjects
    case getProject(projectId: String)
    case getPosts(projectId: String, page: Int, size: Int)
    case getPost(projectId: String, postId: String)
}

extension MyAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .getProjects:
            return "/my/projects"
        case .getProject(let projectId):
            return "/my/projects/\(projectId)"
        case .getPosts(let projectId, _, _):
            return "/my/projects/\(projectId)/posts"
        case .getPost(let projectId, let postId):
            return "/my/projects/\(projectId)/posts/\(postId)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getProjects,
             .getProject,
             .getPosts,
             .getPost:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .getProjects,
             .getProject:
            return jsonSerializedUTF8(json: ProjectViewResponse.sampleData())
        case .getPosts:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        case .getPost:
            return jsonSerializedUTF8(json: PostViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .getProjects,
             .getProject,
             .getPost:
            return .requestPlain
        case .getPosts(_, let page, let size):
            let param = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

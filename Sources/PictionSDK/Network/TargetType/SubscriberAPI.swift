//
//  SubscriberAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum SubscriberAPI {
    case projects(page: Int, size: Int)
    case latestPosts(page: Int, size: Int)
}

extension SubscriberAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .projects:
            return "/my/subscriptions/projects"
        case .latestPosts:
            return "/my/subscriptions/projects/posts"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .projects,
             .latestPosts:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .projects:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        case .latestPosts:
            return jsonSerializedUTF8(json: PageViewResponse<SubscribingPostModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .projects(let page, let size),
             .latestPosts(let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

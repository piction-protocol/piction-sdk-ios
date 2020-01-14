//
//  SearchAPI.swift
//  PictionSDK
//
//  Created by jhseo on 09/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum SearchAPI {
    case projects(name: String, page: Int, size: Int)
    case taggingProjects(tag: String, page: Int, size: Int)
    case tag(tag: String, page: Int, size: Int)
    case writer(writer: String, page: Int, size: Int)
}

extension SearchAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .projects:
            return "/search/projects"
        case .taggingProjects:
            return "/search/projects/tags"
        case .tag:
            return "/search/tags"
        case .writer:
            return "/search/writers"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .projects,
             .taggingProjects,
             .tag,
             .writer:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .projects,
             .taggingProjects:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        case .tag:
            return jsonSerializedUTF8(json: PageViewResponse<TagModel>.sampleData())
        case .writer:
            return jsonSerializedUTF8(json: PageViewResponse<UserModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .projects(let name, let page, let size):
            var param: [String: Any] = [:]
            param["name"] = name
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .taggingProjects(let tag, let page, let size),
             .tag(let tag, let page, let size):
            var param: [String: Any] = [:]
            param["tag"] = tag
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .writer(let writer, let page, let size):
            var param: [String: Any] = [:]
            param["writer"] = writer
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

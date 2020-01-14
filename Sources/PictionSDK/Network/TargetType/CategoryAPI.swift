//
//  CategoryAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/08.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum CategoryAPI {
    case all
    case get(id: Int)
    case categorizedProjects(id: Int, page: Int, size: Int)
}

extension CategoryAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all:
            return "/categories"
        case .get(let id):
            return "/categories/\(id)"
        case .categorizedProjects(let id, _, _):
            return "/categories/\(id)/projects"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [CategoryViewResponse.sampleData()])
        case .get:
            return jsonSerializedUTF8(json: CategoryViewResponse.sampleData())
        case .categorizedProjects:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .get:
            return .requestPlain
        case .categorizedProjects(_, let page, let size):
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

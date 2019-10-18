//
//  RecommendationAPI.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum RecommendationAPI {
    case all(size: Int)
    case add(uri: String)
    case delete(uri: String)
}

extension RecommendationAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all:
            return "/recommended/projects"
        case .add(let uri),
            .delete(let uri):
            return "/recommended/projects/\(uri)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all:
            return .get
        case .add:
            return .post
        case .delete:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .add,
             .delete:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all(let size):
            var param: [String: Any] = [:]
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .add,
             .delete:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

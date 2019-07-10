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
    case project(name: String, page: Int, size: Int)
    case writer(writer: String, page: Int, size: Int)
}

extension SearchAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .project:
            return "/search/projects"
        case .writer:
            return "/search/writers"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .project,
             .writer:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .project:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        case .writer:
            return jsonSerializedUTF8(json: PageViewResponse<SeriesModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .project(let name, let page, let size):
            let param: [String : Any] = [
                "name": name,
                "page": page,
                "size": size
                ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .writer(let writer, let page, let size):
            let param: [String : Any] = [
                "writer": writer,
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

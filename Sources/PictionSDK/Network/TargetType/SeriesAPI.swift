//
//  SeriesAPI.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum SeriesAPI {
    case all(projectId: String)
    case create(projectId: String, name: String)
    case updatePriority(projectId: String, seriesIdList: [Int])
    case get(projectId: String, seriesId: Int)
    case update(projectId: String, seriesId: Int, name: String)
    case delete(projectId: String, seriesId: Int)
    case allSeriesPosts(projectId: String, seriesId: Int)
}

extension SeriesAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let projectId),
             .create(let projectId, _),
             .updatePriority(let projectId, _):
            return "/projects/\(projectId)/series"
        case .get(let projectId, let seriesId),
             .update(let projectId, let seriesId, _),
             .delete(let projectId, let seriesId):
            return "/projects/\(projectId)/series/\(seriesId)"
        case .allSeriesPosts(let projectId, let seriesId):
            return "/projects/\(projectId)/series/\(seriesId)/posts"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .get,
             .allSeriesPosts:
            return .get
        case .create:
            return .post
        case .updatePriority,
             .update:
            return .put
        case .delete:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all,
             .updatePriority:
            return jsonSerializedUTF8(json: [SeriesViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: SeriesViewResponse.sampleData())
        case .delete:
            return jsonSerializedUTF8(json: DefaultResponse.sampleData())
        case .allSeriesPosts:
            return jsonSerializedUTF8(json: [PostViewResponse.sampleData()])
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .get,
             .delete,
             .allSeriesPosts:
            return .requestPlain
        case .create(_, let name),
             .update(_, _, let name):
            let param = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .updatePriority(_, let seriesIdList):
            let param = [
                "seriesIdList": seriesIdList
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

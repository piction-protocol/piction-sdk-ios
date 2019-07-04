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
    case all(uri: String)
    case create(uri: String, name: String)
    case sort(uri: String, seriesIdList: [Int])
    case get(uri: String, seriesId: Int)
    case update(uri: String, seriesId: Int, name: String)
    case delete(uri: String, seriesId: Int)
    case allSeriesPosts(uri: String, seriesId: Int, page: Int, size: Int)
}

extension SeriesAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let uri),
             .create(let uri, _),
             .sort(let uri, _):
            return "/projects/\(uri)/series"
        case .get(let uri, let seriesId),
             .update(let uri, let seriesId, _),
             .delete(let uri, let seriesId):
            return "/projects/\(uri)/series/\(seriesId)"
        case .allSeriesPosts(let uri, let seriesId, _, _):
            return "/projects/\(uri)/series/\(seriesId)/posts"
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
        case .sort,
             .update:
            return .put
        case .delete:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all,
             .sort:
            return jsonSerializedUTF8(json: [SeriesViewResponse.sampleData()])
        case .create,
             .get,
             .update:
            return jsonSerializedUTF8(json: SeriesViewResponse.sampleData())
        case .delete:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .allSeriesPosts:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .get,
             .delete:
            return .requestPlain
        case .create(_, let name),
             .update(_, _, let name):
            let param = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .sort(_, let seriesIdList):
            let param = [
                "seriesIdList": seriesIdList
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .allSeriesPosts(_, _, let page, let size):
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

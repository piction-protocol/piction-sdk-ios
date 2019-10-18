//
//  TagsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 18/10/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum TagsAPI {
    case popular
    case popularAll
}

extension TagsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .popular:
            return "/tags/popular"
        case .popularAll:
            return "/tags/popular/all"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .popular,
             .popularAll:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .popular,
             .popularAll:
            return jsonSerializedUTF8(json: [TagViewResponse.sampleData()])
        }
    }
    public var task: Task {
        switch self {
        case .popular,
             .popularAll:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

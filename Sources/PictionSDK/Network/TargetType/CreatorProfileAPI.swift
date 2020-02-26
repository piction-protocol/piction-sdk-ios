//
//  CreatorProfileAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/02/20.
//  Copyright © 2020 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum CreatorProfileAPI {
    case createCreatorProfile(loginId: String)
    case getCreatorProfile(loginId: String)
}

extension CreatorProfileAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .createCreatorProfile(let loginId):
            return "/creator-profiles/users/\(loginId)"
        case .getCreatorProfile(let loginId):
            return "/creator-profiles/users/\(loginId)/projects"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .createCreatorProfile,
             .getCreatorProfile:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .createCreatorProfile:
            return jsonSerializedUTF8(json: CreatorProfileViewResponse.sampleData())
        case .getCreatorProfile:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        }
    }
    public var task: Task {
        switch self {
        case .createCreatorProfile,
             .getCreatorProfile:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

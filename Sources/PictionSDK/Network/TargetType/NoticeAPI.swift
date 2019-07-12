//
//  NoticeAPI.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum NoticeAPI {
    case all
    case events
    case notices
}

extension NoticeAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all:
            return "/banners"
        case .events:
            return "/banners/events"
        case .notices:
            return "/banners/notices"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .all,
             .events,
             .notices:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .all,
             .events,
             .notices:
            return jsonSerializedUTF8(json: [BannerViewResponse.sampleData()])
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .events,
             .notices:
            return .requestPlain
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

//
//  SponsorshipsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum SponsorshipsAPI {
    case get(page: Int, size: Int)
    case sponsorship(creatorId: String, amount: Double)
}

extension SponsorshipsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        default:
            return "/sponsorships"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .get:
            return .get
        case .sponsorship:
            return .post
        }
    }
    public var sampleData: Data {
        switch self {
        case .get:
            return jsonSerializedUTF8(json: PageViewResponse<SponsorshipModel>.sampleData())
        case .sponsorship:
            return jsonSerializedUTF8(json: SponsorshipModel.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .get(let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .sponsorship(let creatorId, let amount):
            var param: [String: Any] = [:]
            param["creatorId"] = creatorId
            param["amount"] = amount
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

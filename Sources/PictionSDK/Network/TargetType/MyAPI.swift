//
//  MyAPI.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum MyAPI {
    case projects
    case transactions(page: Int, size: Int)
    case wallet
}

extension MyAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .projects:
            return "/my-projects"
        case .transactions:
            return "/my-transactions"
        case .wallet:
            return "/my-wallet"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .projects,
             .transactions,
             .wallet:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .projects:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .transactions:
            return jsonSerializedUTF8(json: PageViewResponse<TransactionModel>.sampleData())
        case .wallet:
            return jsonSerializedUTF8(json: WalletViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .projects,
             .wallet:
            return .requestPlain
        case .transactions(let page, let size):
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

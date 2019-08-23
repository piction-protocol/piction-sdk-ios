//
//  MyAPI.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum MyAPI {
    case projects
    case transactions(page: Int, size: Int)
    case wallet
    case sales(salesYear: Int, salesMonth: Int)
    case subscription(page: Int, size: Int)
}

extension MyAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .projects:
            return "/my/projects"
        case .transactions:
            return "/my/transactions"
        case .wallet:
            return "/my/wallet"
        case .sales:
            return "/my/sales"
        case .subscription:
            return "/my/subscriptions"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .projects,
             .transactions,
             .wallet,
             .sales,
             .subscription:
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
        case .sales:
            return jsonSerializedUTF8(json: [SalesViewResponse.sampleData()])
        case .subscription:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .projects,
             .wallet:
            return .requestPlain
        case .transactions(let page, let size),
             .subscription(let page, let size):
            let param = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .sales(let salesYear, let salesMonth):
            let param = [
                "salesYear": salesYear,
                "salesMonth": salesMonth
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

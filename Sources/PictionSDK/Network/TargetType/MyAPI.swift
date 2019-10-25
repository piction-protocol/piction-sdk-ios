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
    case posts(uri: String, seriesId: Int, isRequiredFanPass: Bool?, page: Int, size: Int)
    case projectSubscriptions(uri: String, page: Int, size: Int)
    case projectsCount
    case transactions(page: Int, size: Int)
    case wallet
    case sales(salesYear: Int, salesMonth: Int)
    case subscription(page: Int, size: Int)
    case sponsorshipTransaction(txHash: String)
    case subscriptionTransaction(txHash: String)
}

extension MyAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .projects:
            return "/my/projects"
        case .posts(let uri, _, _, _, _):
            return "/my/projects/\(uri)/posts"
        case .projectSubscriptions(let uri, _, _):
            return "/my/projects/\(uri)/subscriptions"
        case .projectsCount:
            return "/my/projects/count"
        case .transactions:
            return "/my/transactions"
        case .wallet:
            return "/my/wallet"
        case .sales:
            return "/my/sales"
        case .subscription:
            return "/my/subscriptions"
        case .sponsorshipTransaction(let txHash):
            return "/my/transactions/sponsorship/\(txHash)"
        case .subscriptionTransaction(let txHash):
            return "/my/transactions/subscription/\(txHash)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .projects,
             .posts,
             .projectSubscriptions,
             .projectsCount,
             .transactions,
             .wallet,
             .sales,
             .subscription,
             .sponsorshipTransaction,
             .subscriptionTransaction:
            return .get
        }
    }
    public var sampleData: Data {
        switch self {
        case .projects:
            return jsonSerializedUTF8(json: [ProjectViewResponse.sampleData()])
        case .posts:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        case .projectSubscriptions:
            return jsonSerializedUTF8(json: PageViewResponse<PostModel>.sampleData())
        case .projectsCount:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .transactions:
            return jsonSerializedUTF8(json: PageViewResponse<TransactionModel>.sampleData())
        case .wallet:
            return jsonSerializedUTF8(json: WalletViewResponse.sampleData())
        case .sales:
            return jsonSerializedUTF8(json: [SalesViewResponse.sampleData()])
        case .subscription:
            return jsonSerializedUTF8(json: PageViewResponse<ProjectModel>.sampleData())
        case .sponsorshipTransaction:
            return jsonSerializedUTF8(json: SponsorshipViewResponse.sampleData())
        case .subscriptionTransaction:
            return jsonSerializedUTF8(json: SubscriptionViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .projects,
             .wallet,
             .sponsorshipTransaction,
             .subscriptionTransaction,
             .projectsCount:
            return .requestPlain
        case .posts(_, _, _, let page, let size),
             .projectSubscriptions(_, let page, let size),
             .transactions(let page, let size),
             .subscription(let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .sales(let salesYear, let salesMonth):
            var param: [String: Any] = [:]
            param["salesYear"] = salesYear
            param["salesMonth"] = salesMonth
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

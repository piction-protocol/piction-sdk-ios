//
//  WalletAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum WalletAPI {
    case get
    case transactions(page: Int, size: Int)
    case sponsorshipTransaction(txHash: String)
    case withdrawTransaction(txHash: String)
    case withdrawals(page: Int, size: Int)
}

extension WalletAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .get:
            return "/my/wallet"
        case .transactions:
            return "/my/wallet/transactions"
        case .sponsorshipTransaction(let txHash):
            return "/my/wallet/transactions/sponsorships/\(txHash)"
        case .withdrawTransaction(let txHash):
            return "/my/wallet/withdrawals/\(txHash)"
        case .withdrawals:
            return "/my/wallet/withdrawals"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var sampleData: Data {
        switch self {
        case .get:
            return jsonSerializedUTF8(json: WalletViewResponse.sampleData())
        case .transactions:
            return jsonSerializedUTF8(json: PageViewResponse<TransactionModel>.sampleData())
        case .sponsorshipTransaction:
            return jsonSerializedUTF8(json: TransactionSponsorshipViewResponse.sampleData())
        case .withdrawTransaction:
            return jsonSerializedUTF8(json: WithdrawalViewResponse.sampleData())
        case .withdrawals:
            return jsonSerializedUTF8(json: PageViewResponse<WithdrawalModel>.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .get,
             .sponsorshipTransaction,
             .withdrawTransaction:
            return .requestPlain
        case .transactions(let page, let size),
             .withdrawals(let page, let size):
            var param: [String: Any] = [:]
            param["page"] = page
            param["size"] = size
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

//
//  Wallet.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Wallet {
    static let shared = Wallet()
    private init() {}

    public func get(success successCompletion: @escaping SuccessClosure<WalletViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(WalletAPI.get,
            success: { (response: WalletViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func transactions(page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<TransactionModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(WalletAPI.transactions(page: page, size: size),
            success: { (response: PageViewResponse<TransactionModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func sponsorshipTransaction(txHash: String, success successCompletion: @escaping SuccessClosure<TransactionSponsorshipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(WalletAPI.sponsorshipTransaction(txHash: txHash),
            success: { (response: TransactionSponsorshipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func withdrawTransaction(txHash: String, success successCompletion: @escaping SuccessClosure<WithdrawalViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(WalletAPI.withdrawTransaction(txHash: txHash),
            success: { (response: WithdrawalViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func withdrawals(page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<WithdrawalModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(WalletAPI.withdrawals(page: page, size: size),
            success: { (response: PageViewResponse<WithdrawalModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

//
//  My.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class My {
    static let shared = My()
    private init() {}

    public func projects(success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.projects,
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func transactions(page: Int, size: Int, success successCompletion: ((PageViewResponse<TransactionModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.transactions(page: page, size: size),
            success: { (response: PageViewResponse<TransactionModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func wallet(success successCompletion: ((WalletViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.wallet,
            success: { (response: WalletViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func sales(salesYear: Int, salesMonth: Int, success successCompletion: (([SalesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.sales(salesYear: salesYear, salesMonth: salesMonth),
            success: { (response: [SalesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func subscription(page: Int, size: Int, success successCompletion: ((PageViewResponse<ProjectModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.subscription(page: page, size: size),
            success: { (response: PageViewResponse<ProjectModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func sponsorshipTransaction(txHash: String, success successCompletion: ((SponsorshipViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.sponsorshipTransaction(txHash: txHash),
            success: { (response: SponsorshipViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func subscriptionTransaction(txHash: String, success successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(MyAPI.subscriptionTransaction(txHash: txHash),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

//
//  My.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

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
}

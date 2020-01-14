//
//  Creator.swift
//  PictionSDK
//
//  Created by jhseo on 14/01/2020.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Creator {
    static let shared = Creator()
    private init() {}

    public func projects(success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CreatorAPI.projects,
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func posts(uri: String, seriesId: Int? = nil, condition: String? = nil, fanPassLevel: Int? = nil, page: Int, size: Int, success successCompletion: ((PageViewResponse<PostModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CreatorAPI.posts(uri: uri, seriesId: seriesId, condition: condition, fanPassLevel: fanPassLevel, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func projectSubscriptions(uri: String, fanPassId: Int? = nil, page: Int, size: Int, success successCompletion: ((PageViewResponse<SubscriptionUserModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CreatorAPI.projectSubscriptions(uri: uri, fanPassId: fanPassId, page: page, size: size),
            success: { (response: PageViewResponse<SubscriptionUserModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func projectsCount(success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CreatorAPI.projectsCount,
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func sales(salesYear: Int, salesMonth: Int, success successCompletion: (([SalesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CreatorAPI.sales(salesYear: salesYear, salesMonth: salesMonth),
            success: { (response: [SalesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

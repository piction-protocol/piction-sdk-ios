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

    public func projects(success successCompletion: @escaping SuccessClosure<[ProjectViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorAPI.projects,
            success: { (response: [ProjectViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func posts(uri: String, seriesId: Int? = nil, condition: String? = nil, membershipLevel: Int? = nil, page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<PostModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorAPI.posts(uri: uri, seriesId: seriesId, condition: condition, membershipLevel: membershipLevel, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func projectSponsors(uri: String, membershipId: Int? = nil, page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<SponsorModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorAPI.projectSponsors(uri: uri, membershipId: membershipId, page: page, size: size),
            success: { (response: PageViewResponse<SponsorModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func projectsCount(success successCompletion: @escaping SuccessClosure<DefaultViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorAPI.projectsCount,
            success: { (response: DefaultViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func sales(salesYear: Int, salesMonth: Int, success successCompletion: @escaping SuccessClosure<[SalesViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorAPI.sales(salesYear: salesYear, salesMonth: salesMonth),
            success: { (response: [SalesViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

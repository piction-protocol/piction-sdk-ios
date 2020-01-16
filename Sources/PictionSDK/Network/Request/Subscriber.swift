//
//  Subscriber.swift
//  PictionSDK
//
//  Created by jhseo on 14/01/2020.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Subscriber {
    static let shared = Subscriber()
    private init() {}

    public func projects(page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<ProjectModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(SubscriberAPI.projects(page: page, size: size),
            success: { (response: PageViewResponse<ProjectModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func latestPosts(page: Int, size: Int, success successCompletion: @escaping SuccessClosure<SubscribingPostViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(SubscriberAPI.latestPosts(page: page, size: size),
            success: { (response: SubscribingPostViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}


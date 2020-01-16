//
//  Recommendation.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Recommendation {
    static let shared = Recommendation()
    private init() {}

    public func all(size: Int, success successCompletion: @escaping SuccessClosure<[ProjectViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(RecommendationAPI.all(size: size),
            success: { (response: [ProjectViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

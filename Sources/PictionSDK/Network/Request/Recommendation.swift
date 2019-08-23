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

    public func all(size: Int, success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(RecommendationAPI.all(size: size),
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func add(uri: String, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(RecommendationAPI.add(uri: uri),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func delete(uri: String, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(RecommendationAPI.delete(uri: uri),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

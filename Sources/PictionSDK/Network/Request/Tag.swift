//
//  Tag.swift
//  PictionSDK
//
//  Created by jhseo on 18/10/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Tag {
    static let shared = Tag()
    private init() {}

    public func popular(success successCompletion: (([TagModel]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(TagAPI.popular,
            success: { (response: [TagModel]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func popularAll(success successCompletion: (([TagModel]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(TagAPI.popularAll,
            success: { (response: [TagModel]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

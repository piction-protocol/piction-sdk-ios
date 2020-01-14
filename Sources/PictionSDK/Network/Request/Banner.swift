//
//  Banner.swift
//  PictionSDK
//
//  Created by jhseo on 10/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Banner {
    static let shared = Banner()
    private init() {}

    public func all(success successCompletion: (([BannerViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(BannerAPI.all,
            success: { (response: [BannerViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func events(success successCompletion: (([BannerViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(BannerAPI.events,
            success: { (response: [BannerViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func notices(success successCompletion: (([BannerViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(BannerAPI.notices,
            success: { (response: [BannerViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

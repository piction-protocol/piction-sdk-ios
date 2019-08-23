//
//  Sponsorships.swift
//  PictionSDK
//
//  Created by jhseo on 05/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Sponsorships {
    static let shared = Sponsorships()
    private init() {}

    public func get(page: Int, size: Int, success successCompletion: ((PageViewResponse<SponsorshipModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SponsorshipsAPI.get(page: page, size: size),
            success: { (response: PageViewResponse<SponsorshipModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func sponsorship(creatorId: String, amount: Int, success successCompletion: ((SponsorshipModel) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SponsorshipsAPI.sponsorship(creatorId: creatorId, amount: amount),
            success: { (response: SponsorshipModel) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

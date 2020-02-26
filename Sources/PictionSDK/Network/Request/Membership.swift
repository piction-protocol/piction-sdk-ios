//
//  Membership.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Membership {
    static let shared = Membership()
    private init() {}

    public func all(uri: String, success successCompletion: @escaping SuccessClosure<[MembershipViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.all(uri: uri),
            success: { (response: [MembershipViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func create(uri: String, name: String, description: String? = nil, thumbnail: String? = nil, sponsorLimit: Int? = nil, price: Int? = nil, success successCompletion: @escaping SuccessClosure<MembershipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.create(uri: uri, name: name, description: description, thumbnail: thumbnail, sponsorLimit: sponsorLimit, price: price),
            success: { (response: MembershipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func get(uri: String, membershipId: Int, success successCompletion: @escaping SuccessClosure<MembershipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.get(uri: uri, membershipId: membershipId),
            success: { (response: MembershipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func update(uri: String, membershipId: Int, name: String, description: String? = nil, thumbnail: String? = nil, sponsorLimit: Int? = nil, price: Int? = nil, success successCompletion: @escaping SuccessClosure<MembershipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.update(uri: uri, membershipId: membershipId, name: name, description: description, thumbnail: thumbnail, sponsorLimit: sponsorLimit, price: price),
            success: { (response: MembershipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func delete(uri: String, membershipId: Int, success successCompletion: @escaping SuccessClosure<DefaultViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.delete(uri: uri, membershipId: membershipId),
            success: { (response: DefaultViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func sponsorship(uri: String, membershipId: Int, sponsorshipPrice: Int, success successCompletion: @escaping SuccessClosure<SponsorshipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.sponsorship(uri: uri, membershipId: membershipId, sponsorshipPrice: sponsorshipPrice),
            success: { (response: SponsorshipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func cancelSponsorship(uri: String, membershipId: Int, success successCompletion: @escaping SuccessClosure<DefaultViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.cancelSponsorship(uri: uri, membershipId: membershipId),
            success: { (response: DefaultViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getSponsoredMembership(uri: String, success successCompletion: @escaping SuccessClosure<SponsorshipViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.getSponsoredMembership(uri: uri),
            success: { (response: SponsorshipViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadThumbnail(uri: String, image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(MembershipAPI.uploadThumbnail(uri: uri, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

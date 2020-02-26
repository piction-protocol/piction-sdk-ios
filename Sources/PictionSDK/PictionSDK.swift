//
//  PictionSDK.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import Mapper

public final class PictionSDK {
    public static let user = User.shared
    public static let session = Session.shared
    public static let project = Project.shared
    public static let membership = Membership.shared
    public static let post = Post.shared
    public static let creator = Creator.shared
    public static let sponsor = Sponsor.shared
    public static let wallet = Wallet.shared
    public static let series = Series.shared
    public static let search = Search.shared
    public static let recommendation = Recommendation.shared
    public static let category = Category.shared
    public static let creatorProfile = CreatorProfile.shared

    public static func requestAPI<M: Mappable, T: TargetType>(_ target: T, success successCompletion: @escaping SuccessClosure<M>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(target,
            success: { (response: M) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

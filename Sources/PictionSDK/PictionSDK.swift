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
    public static let my = My.shared
    public static let users = User.shared
    public static let session = Session.shared
    public static let project = Project.shared
    public static let post = Post.shared
    public static let series = Series.shared
    public static let search = Search.shared
    public static let recommendation = Recommendation.shared
    public static let banner = Banner.shared
    public static let tag = Tag.shared
    public static let category = Category.shared

    public static func requestAPI<M: Mappable, T: TargetType>(_ target: T, success successCompletion: ((M) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(target,
            success: { (response: M) in
                if T.self == SessionAPI.self {
                    let token = response as? AuthenticationViewResponse
//                    PictionManager.setToken(token?.accessToken ?? "")
                }
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

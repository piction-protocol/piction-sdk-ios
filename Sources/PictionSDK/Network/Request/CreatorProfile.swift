//
//  CreatorProfile.swift
//  PictionSDK
//
//  Created by jhseo on 2020/02/20.
//  Copyright © 2020 Piction Network. All rights reserved.
//

import Foundation

public final class CreatorProfile {
    static let shared = CreatorProfile()
    private init() {}

    public func createCreatorProfile(loginId: String, success successCompletion: @escaping SuccessClosure<CreatorProfileViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorProfileAPI.createCreatorProfile(loginId: loginId),
            success: { (response: CreatorProfileViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getCreatorProfile(loginId: String, success successCompletion: @escaping SuccessClosure<[ProjectViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(CreatorProfileAPI.getCreatorProfile(loginId: loginId),
            success: { (response: [ProjectViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }


}

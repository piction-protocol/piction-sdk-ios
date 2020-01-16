//
//  Session.swift
//  PictionSDK
//
//  Created by jhseo on 21/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Session {
    static let shared = Session()
    private init() {}

    public func create(loginId: String, password: String, rememberme: Bool, success successCompletion: @escaping SuccessClosure<AuthenticationViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(SessionAPI.create(loginId: loginId, password: password, rememberme: rememberme),
            success: { (response: AuthenticationViewResponse) in
//                PictionManager.setToken(response.accessToken ?? "")
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func delete(success successCompletion: @escaping SuccessClosure<AuthenticationViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(SessionAPI.delete,
            success: { (response: AuthenticationViewResponse) in
//                PictionManager.setToken(response.accessToken ?? "")
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

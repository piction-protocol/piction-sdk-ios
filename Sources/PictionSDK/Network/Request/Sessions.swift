//
//  Sessions.swift
//  PictionSDK
//
//  Created by jhseo on 21/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Sessions {
    static let shared = Sessions()
    private init() {}

    public func create(email: String, password: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SessionsAPI.create(email: email, password: password),
            success: { (response: AuthenticationViewResponse) in
                PictionManager.setToken(response.accessToken ?? "")
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

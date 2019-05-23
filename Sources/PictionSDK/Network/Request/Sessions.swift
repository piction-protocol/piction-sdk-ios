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

    public func create(username: String, password: String, success successCompletion: ((AuthenticationResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        request(SessionsAPI.create(username: username, password: password),
            success: { (response: AuthenticationResponse) in
                PictionManager.setToken(response.accessToken ?? "")
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

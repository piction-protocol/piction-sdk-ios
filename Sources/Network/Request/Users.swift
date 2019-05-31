//
//  Users.swift
//  PictionSDK
//
//  Created by jhseo on 08/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Users {
    static let shared = Users()
    private init() {}

    public func signup(email: String, username: String, password: String, success successCompletion: ((AuthenticationResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        request(UsersAPI.signup(email: email, username: username, password: password),
            success: { (response: AuthenticationResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func me(success successCompletion: ((CurrentUserResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        request(UsersAPI.me,
            success: { (response: CurrentUserResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(email: String, username: String, password: String, picture: String, success successCompletion: ((CurrentUserResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        request(UsersAPI.update(email: email, username: username, password: password, picture: picture),
            success: { (response: CurrentUserResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func updatePassword(password: String, newPassword: String, confirmPassword: String, success successCompletion: ((AuthenticationResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        request(UsersAPI.updatePassword(password: password, newPassword: newPassword, confirmPassword: confirmPassword),
            success: { (response: AuthenticationResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

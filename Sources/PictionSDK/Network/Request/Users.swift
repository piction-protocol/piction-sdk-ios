//
//  Users.swift
//  PictionSDK
//
//  Created by jhseo on 08/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Users {
    static let shared = Users()
    private init() {}

    public func signup(email: String, username: String, password: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.signup(email: email, username: username, password: password),
            success: { (response: AuthenticationViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func me(success successCompletion: ((UserViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.me,
            success: { (response: UserViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(email: String, username: String, password: String, picture: String?, success successCompletion: ((UserViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.update(email: email, username: username, password: password, picture: picture),
            success: { (response: UserViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func updatePassword(password: String, newPassword: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.updatePassword(password: password, newPassword: newPassword),
            success: { (response: AuthenticationViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadPicture(image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.uploadPicture(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func transactions(page: Int, size: Int, success successCompletion: ((PageViewResponse<TransactionModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.transactions(page: page, size: size),
            success: { (response: PageViewResponse<TransactionModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

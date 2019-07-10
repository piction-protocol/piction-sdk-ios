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

    public func findAll(success successCompletion: (([UserViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.findAll,
            success: { (response: [UserViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func signup(loginId: String, email: String, username: String, password: String, passwordCheck: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.signup(loginId: loginId, email: email, username: username, password: password, passwordCheck: passwordCheck),
            success: { (response: AuthenticationViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func findOne(id: Int, success successCompletion: ((UserViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.findOne(id: id),
            success: { (response: UserViewResponse) in
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

    public func updatePassword(password: String, newPassword: String, passwordCheck: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(UsersAPI.updatePassword(password: password, newPassword: newPassword, passwordCheck: passwordCheck),
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
}

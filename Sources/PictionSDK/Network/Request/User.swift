//
//  User.swift
//  PictionSDK
//
//  Created by jhseo on 08/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class User {
    static let shared = User()
    private init() {}

    public func signup(loginId: String, email: String, username: String, password: String, passwordCheck: String, success successCompletion: @escaping SuccessClosure<AuthenticationViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.signup(loginId: loginId, email: email, username: username, password: password, passwordCheck: passwordCheck),
            success: { (response: AuthenticationViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func findOne(id: String, success successCompletion: @escaping SuccessClosure<UserViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.findOne(id: id),
            success: { (response: UserViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func me(success successCompletion: @escaping SuccessClosure<UserViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.me,
            success: { (response: UserViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func update(username: String, password: String, picture: String? = nil, success successCompletion: @escaping SuccessClosure<UserViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.update(username: username, password: password, picture: picture),
            success: { (response: UserViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func updatePassword(password: String, newPassword: String, passwordCheck: String, success successCompletion: @escaping SuccessClosure<AuthenticationViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.updatePassword(password: password, newPassword: newPassword, passwordCheck: passwordCheck),
            success: { (response: AuthenticationViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadPicture(image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.uploadPicture(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func findPublicAddress(address: String, success successCompletion: @escaping SuccessClosure<UserViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(UserAPI.findPublicAddress(address: address),
            success: { (response: UserViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
        })
    }
}

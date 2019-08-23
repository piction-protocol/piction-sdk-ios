//
//  FanPass.swift
//  PictionSDK
//
//  Created by jhseo on 06/08/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class FanPass {
    static let shared = FanPass()
    private init() {}

    public func get(fanPassId: Int, success successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.get(fanPassId: fanPassId),
            success: { (response: FanPassViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(fanPassId: Int, name: String, description: String, thumbnail: String, subscriptionLimit: Int, subscriptionPrice: Int, status: Bool, successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.update(fanPassId: fanPassId, name: name, description: description, thumbnail: thumbnail, subscriptionLimit: subscriptionLimit, subscriptionPrice: subscriptionPrice, status: status),
                success: { (response: FanPassViewResponse) in
                    successCompletion?(response)
            },
                failure: { error in
                    failureCompletion?(error)
            })
    }

    public func isSubscription(uri: String, successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.isSubscription(uri: uri),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func subscription(fanPassId: Int, subscriptionPrice: Int, successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.subscription(fanPassId: fanPassId, subscriptionPrice: subscriptionPrice),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func delete(fanPassId: Int, successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.delete(fanPassId: fanPassId),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func projectAll(uri: String, successCompletion: (([FanPassViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.projectAll(uri: uri),
            success: { (response: [FanPassViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(uri: String, level: Int, name: String, description: String, thumbnail: String, subscriptionLimit: Int, subscriptionPrice: Int, status: Bool, successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.create(uri: uri, level: level, name: name, description: description, thumbnail: thumbnail, subscriptionLimit: subscriptionLimit, subscriptionPrice: subscriptionPrice, status: status),
            success: { (response: FanPassViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadThumbnail(image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(FanPassAPI.uploadThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

}

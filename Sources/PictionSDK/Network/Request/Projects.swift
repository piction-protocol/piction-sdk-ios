//
//  Projects.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Projects {
    static let shared = Projects()
    private init() {}

    public func all(page: Int, size: Int, tagName: String? = nil, success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.all(page: page, size: size, tagName: tagName),
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.create(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail, tags: tags, status: status),
            success: { (response: ProjectViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(uri: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.get(uri: uri),
            success: { (response: ProjectViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.update(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail, tags: tags, status: status),
            success: { (response: ProjectViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadThumbnail(image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.uploadThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadWideThumbnail(image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.uploadWideThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func trending(success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.trending,
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func fanPassAll(uri: String, success successCompletion: (([FanPassViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.fanPassAll(uri: uri),
            success: { (response: [FanPassViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func createFanPass(uri: String, name: String, description: String, thumbnail: String? = nil, subscriptionLimit: Int, subscriptionPrice: Int, success successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.createFanPass(uri: uri, name: name, description: description, thumbnail: thumbnail, subscriptionLimit: subscriptionLimit, subscriptionPrice: subscriptionPrice),
            success: { (response: FanPassViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func fanPass(uri: String, fanPassId: Int, success successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.fanPass(uri: uri, fanPassId: fanPassId),
            success: { (response: FanPassViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func updateFanPass(uri: String, fanPassId: Int, name: String, description: String, thumbnail: String? = nil, subscriptionLimit: Int, subscriptionPrice: Int, success successCompletion: ((FanPassViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.updateFanPass(uri: uri, fanPassId: fanPassId, name: name, description: description, thumbnail: thumbnail, subscriptionLimit: subscriptionLimit, subscriptionPrice: subscriptionPrice),
            success: { (response: FanPassViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func deleteFanPass(uri: String, fanPassId: Int, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.deleteFanPass(uri: uri, fanPassId: fanPassId),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func subscription(uri: String, fanPassId: Int, subscriptionPrice: Int, success successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.subscription(uri: uri, fanPassId: fanPassId, subscriptionPrice: subscriptionPrice),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func cancelSubscription(uri: String, fanPassId: Int, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.cancelSubscription(uri: uri, fanPassId: fanPassId),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func getProjectSubscription(uri: String, success successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.getProjectSubscription(uri: uri),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadFanPassThumbnail(image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.uploadFanPassThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func fees(uri: String, success successCompletion: ((FeesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.fees(uri: uri),
            success: { (response: FeesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

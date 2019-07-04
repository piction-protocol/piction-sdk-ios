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

    public func all(success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.all,
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(uri: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.create(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail),
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

    public func update(uri: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.update(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail),
            success: { (response: ProjectViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func subscription(uri: String, subscriptionPrice: Int, success successCompletion: ((SubscriptionViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.subscription(uri: uri, subscriptionPrice: subscriptionPrice),
            success: { (response: SubscriptionViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func search(name: String, success successCompletion: ((PageViewResponse<ProjectModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.search(name: name),
            success: { (response: PageViewResponse<ProjectModel>) in
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
        PictionProvider.request(ProjectsAPI.uploadThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
                failure: { error in
                    failureCompletion?(error)
            })
    }

    public func recommendedAll(success successCompletion: (([ProjectViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.recommendedAll,
            success: { (response: [ProjectViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func recommendedAdd(uri: String, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.recommendedAdd(uri: uri),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func recommendedDelete(uri: String, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.recommendedDelete(uri: uri),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

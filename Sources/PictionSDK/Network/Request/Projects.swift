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

    public func get(projectId: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.get(projectId: projectId),
            success: { (response: ProjectViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(projectId: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, success successCompletion: ((ProjectViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.update(projectId: projectId, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail),
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

    public func recommendedAdd(projectId: String, success successCompletion: ((DefaultResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.recommendedAdd(projectId: projectId),
            success: { (response: DefaultResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func recommendedDelete(projectId: String, success successCompletion: ((DefaultResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.recommendedDelete(projectId: projectId),
            success: { (response: DefaultResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

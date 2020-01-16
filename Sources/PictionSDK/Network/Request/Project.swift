//
//  Project.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Project {
    static let shared = Project()
    private init() {}

    public func all(page: Int, size: Int, success successCompletion: @escaping SuccessClosure<[ProjectViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.all(page: page, size: size),
            success: { (response: [ProjectViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func create(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String, success successCompletion: @escaping SuccessClosure<ProjectViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.create(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail, tags: tags, status: status),
            success: { (response: ProjectViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func get(uri: String, success successCompletion: @escaping SuccessClosure<ProjectViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.get(uri: uri),
            success: { (response: ProjectViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func update(uri: String, title: String, synopsis: String, thumbnail: String? = nil, wideThumbnail: String? = nil, tags: [String], status: String, success successCompletion: @escaping SuccessClosure<ProjectViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.update(uri: uri, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail, tags: tags, status: status),
            success: { (response: ProjectViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadThumbnail(image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.uploadThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadWideThumbnail(image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.uploadWideThumbnail(image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func trending(success successCompletion: @escaping SuccessClosure<[ProjectViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.trending,
            success: { (response: [ProjectViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func fees(uri: String, success successCompletion: @escaping SuccessClosure<FeesViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(ProjectAPI.fees(uri: uri),
            success: { (response: FeesViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }
}

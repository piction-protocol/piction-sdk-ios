//
//  Posts.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Posts {
    static let shared = Posts()
    private init() {}

    public func all(projectId: String, page: Int, size: Int, success successCompletion: ((PageViewResponse<PostModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.all(projectId: projectId, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(projectId: String, title: String, content: String, cover: String, status: String, membership: String, seriesId: String, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.create(projectId: projectId, title: title, content: content, cover: cover, status: status, membership: membership, seriesId: seriesId),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(projectId: String, postId: String, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.get(projectId: projectId, postId: postId),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(projectId: String, postId: String, title: String, content: String, cover: String, status: String, membership: String, seriesId: String, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.update(projectId: projectId, postId: postId, title: title, content: content, cover: cover, status: status, membership: membership, seriesId: seriesId),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadContentImage(projectId: String, image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.uploadContentImage(projectId: projectId, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadCoverImage(projectId: String, image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostsAPI.uploadCoverImage(projectId: projectId, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
        })
    }
}

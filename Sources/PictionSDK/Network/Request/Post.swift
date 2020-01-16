//
//  Post.swift
//  PictionSDK
//
//  Created by jhseo on 13/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Post {
    static let shared = Post()
    private init() {}

    public func all(uri: String, page: Int, size: Int, success successCompletion: @escaping SuccessClosure<PageViewResponse<PostModel>>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.all(uri: uri, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func create(uri: String, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64,  success successCompletion: @escaping SuccessClosure<PostViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.create(uri: uri, title: title, content: content, cover: cover, seriesId: seriesId, fanPassId: fanPassId, status: status, publishedAt: publishedAt),
            success: { (response: PostViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func get(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<PostViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.get(uri: uri, postId: postId),
            success: { (response: PostViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func update(uri: String, postId: Int, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64, success successCompletion: @escaping SuccessClosure<PostViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.update(uri: uri, postId: postId, title: title, content: content, cover: cover, seriesId: seriesId, fanPassId: fanPassId, status: status, publishedAt: publishedAt),
            success: { (response: PostViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func delete(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<DefaultViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.delete(uri: uri, postId: postId),
            success: { (response: DefaultViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getContent(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<ContentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.getContent(uri: uri, postId: postId),
            success: { (response: ContentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getLike(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<LikeViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.getLike(uri: uri, postId: postId),
            success: { (response: LikeViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func like(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<PostViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.like(uri: uri, postId: postId),
            success: { (response: PostViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getLinks(uri: String, postId: Int, success successCompletion: @escaping SuccessClosure<PostLinkViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.getLinks(uri: uri, postId: postId),
            success: { (response: PostLinkViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func getSeriesLinks(uri: String, postId: Int, count: Int, success successCompletion: @escaping SuccessClosure<[PostIndexViewResponse]>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.getSeriesLinks(uri: uri, postId: postId, count: count),
            success: { (response: [PostIndexViewResponse]) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadContentImage(uri: String, image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.uploadContentImage(uri: uri, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
            })
    }

    public func uploadCoverImage(uri: String, image: UIImage, success successCompletion: @escaping SuccessClosure<StorageAttachmentViewResponse>, failure failureCompletion: @escaping FailureClosure) {
        PictionProvider.request(PostAPI.uploadCoverImage(uri: uri, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion(response)
            },
            failure: { error in
                failureCompletion(error)
        })
    }
}

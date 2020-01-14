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

    public func all(uri: String, page: Int, size: Int, success successCompletion: ((PageViewResponse<PostModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.all(uri: uri, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(uri: String, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64,  success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.create(uri: uri, title: title, content: content, cover: cover, seriesId: seriesId, fanPassId: fanPassId, status: status, publishedAt: publishedAt),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(uri: String, postId: Int, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.get(uri: uri, postId: postId),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(uri: String, postId: Int, title: String, content: String, cover: String? = nil, seriesId: Int? = nil, fanPassId: Int? = nil, status: String, publishedAt: Int64, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.update(uri: uri, postId: postId, title: title, content: content, cover: cover, seriesId: seriesId, fanPassId: fanPassId, status: status, publishedAt: publishedAt),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func delete(uri: String, postId: Int, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.delete(uri: uri, postId: postId),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func content(uri: String, postId: Int, success successCompletion: ((ContentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.getContent(uri: uri, postId: postId),
            success: { (response: ContentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func isLike(uri: String, postId: Int, success successCompletion: ((LikeViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.getLike(uri: uri, postId: postId),
            success: { (response: LikeViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func like(uri: String, postId: Int, success successCompletion: ((PostViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.like(uri: uri, postId: postId),
            success: { (response: PostViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func getLinks(uri: String, postId: Int, success successCompletion: ((PostLinkViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.getLinks(uri: uri, postId: postId),
            success: { (response: PostLinkViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func getSeriesLink(uri: String, postId: Int, count: Int, success successCompletion: (([PostIndexViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.getSeriesLink(uri: uri, postId: postId, count: count),
            success: { (response: [PostIndexViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadContentImage(uri: String, image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.uploadContentImage(uri: uri, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func uploadCoverImage(uri: String, image: UIImage, success successCompletion: ((StorageAttachmentViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(PostAPI.uploadCoverImage(uri: uri, image: image),
            success: { (response: StorageAttachmentViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
        })
    }
}

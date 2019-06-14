//
//  Series.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import UIKit

public final class Series {
    static let shared = Series()
    private init() {}

    public func all(projectId: String, success successCompletion: (([SeriesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.all(projectId: projectId),
            success: { (response: [SeriesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(projectId: String, name: String, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.create(projectId: projectId, name: name),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func updatePriority(projectId: String, name: String, success successCompletion: (([SeriesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.create(projectId: projectId, name: name),
            success: { (response: [SeriesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(projectId: String, seriesId: Int, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.get(projectId: projectId, seriesId: seriesId),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(projectId: String, seriesId: Int, name: String, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.update(projectId: projectId, seriesId: seriesId, name: name),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    // TODO: response?
    public func delete(projectId: String, seriesId: Int, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.delete(projectId: projectId, seriesId: seriesId),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func allSeriesPosts(projectId: String, seriesId: Int, success successCompletion: ((PageViewResponse<PostModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.allSeriesPosts(projectId: projectId, seriesId: seriesId),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion?(response)
            },
                failure: { error in
                    failureCompletion?(error)
            })
    }
}

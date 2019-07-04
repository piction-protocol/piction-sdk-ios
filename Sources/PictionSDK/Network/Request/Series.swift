//
//  Series.swift
//  PictionSDK
//
//  Created by jhseo on 14/06/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Series {
    static let shared = Series()
    private init() {}

    public func all(uri: String, success successCompletion: (([SeriesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.all(uri: uri),
            success: { (response: [SeriesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func create(uri: String, name: String, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.create(uri: uri, name: name),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func sort(uri: String, seriesIdList: [Int], success successCompletion: (([SeriesViewResponse]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.sort(uri: uri, seriesIdList: seriesIdList),
            success: { (response: [SeriesViewResponse]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(uri: String, seriesId: Int, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.get(uri: uri, seriesId: seriesId),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(uri: String, seriesId: Int, name: String, success successCompletion: ((SeriesViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.update(uri: uri, seriesId: seriesId, name: name),
            success: { (response: SeriesViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func delete(uri: String, seriesId: Int, success successCompletion: ((DefaultViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.delete(uri: uri, seriesId: seriesId),
            success: { (response: DefaultViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func allSeriesPosts(uri: String, seriesId: Int, page: Int, size: Int, success successCompletion: ((PageViewResponse<PostModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SeriesAPI.allSeriesPosts(uri: uri, seriesId: seriesId, page: page, size: size),
            success: { (response: PageViewResponse<PostModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

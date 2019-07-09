//
//  Search.swift
//  PictionSDK
//
//  Created by jhseo on 09/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Search {
    static let shared = Search()
    private init() {}

    public func project(name: String, page: Int, size: Int, success successCompletion: ((PageViewResponse<ProjectModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SearchAPI.project(name: name, page: page, size: size),
            success: { (response: PageViewResponse<ProjectModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func writer(name: String, page: Int, size: Int, success successCompletion: ((PageViewResponse<UserModel>) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(SearchAPI.writer(name: name, page: page, size: size),
            success: { (response: PageViewResponse<UserModel>) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

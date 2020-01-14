//
//  Category.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/08.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Category {
    static let shared = Category()
    private init() {}

    public func all(success successCompletion: (([CategoryModel]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CategoryAPI.all,
            success: { (response: [CategoryModel]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(id: Int, success successCompletion: ((CategoryModel) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CategoryAPI.get(id: id),
            success: { (response: CategoryModel) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(id: Int, page: Int, size: Int, success successCompletion: (([ProjectModel]) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(CategoryAPI.categorizedProjects(id: id, page: page, size: size),
            success: { (response: [ProjectModel]) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

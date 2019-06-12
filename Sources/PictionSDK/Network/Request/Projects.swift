//
//  Projects.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

public final class Projects {
    static let shared = Projects()
    private init() {}

    public func create(id: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.create(id: id, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail),
            success: { (response: AuthenticationViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func get(id: String, success successCompletion: ((ProjectResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.get(id: id),
            success: { (response: ProjectResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }

    public func update(id: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String, success successCompletion: ((AuthenticationViewResponse) -> Void)? = nil, failure failureCompletion: ((ErrorType) -> Void)? = nil) {
        PictionProvider.request(ProjectsAPI.update(id: id, title: title, synopsis: synopsis, thumbnail: thumbnail, wideThumbnail: wideThumbnail),
            success: { (response: AuthenticationViewResponse) in
                successCompletion?(response)
            },
            failure: { error in
                failureCompletion?(error)
            })
    }
}

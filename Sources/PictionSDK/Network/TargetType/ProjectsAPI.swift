//
//  ProjectsAPI.swift
//  PictionSDK
//
//  Created by jhseo on 30/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya

public enum ProjectsAPI {
    case create(id: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String)
    case get(id: String)
    case update(id: String, title: String, synopsis: String, thumbnail: String, wideThumbnail: String)
}

extension ProjectsAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .create(_):
            return "/projects"
        case .get(let id),
             .update(let id, _, _, _, _):
            return "/projects/\(id)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .create(_):
            return .post
        case .get(_):
            return .get
        case .update(_):
            return .post
        }
    }
    public var sampleData: Data {
        switch self {
        case .create(_),
             .update(_):
            return jsonSerializedUTF8(json: AuthenticationResponse.sampleData())
        case .get(_):
            return jsonSerializedUTF8(json: ProjectResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .create(let id, let title, let synopsis, let thumbnail, let wideThumbnail):
            let param = [
                "id": id,
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .get(_):
            return .requestPlain
        case .update(_, let title, let synopsis, let thumbnail, let wideThumbnail):
            let param = [
                "title": title,
                "synopsis": synopsis,
                "thumbnail": thumbnail,
                "wideThumbnail": wideThumbnail
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ServerInfo.getCustomHeader()
    }
}

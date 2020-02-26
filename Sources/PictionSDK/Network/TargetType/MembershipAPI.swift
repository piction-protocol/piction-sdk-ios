//
//  MembershipAPI.swift
//  PictionSDK
//
//  Created by jhseo on 2020/01/14.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum MembershipAPI {
    case all(uri: String)
    case create(uri: String, name: String, description: String? = nil, thumbnail: String? = nil, sponsorLimit: Int? = nil, price: Int? = nil)
    case get(uri: String, membershipId: Int)
    case update(uri: String, membershipId: Int, name: String, description: String? = nil, thumbnail: String? = nil, sponsorLimit: Int? = nil, price: Int? = nil)
    case delete(uri: String, membershipId: Int)
    case sponsorship(uri: String, membershipId: Int, sponsorshipPrice: Int)
    case cancelSponsorship(uri: String, membershipId: Int)
    case getSponsoredMembership(uri: String)
    case uploadThumbnail(uri: String, image: UIImage)
}

extension MembershipAPI: TargetType {
    public var baseURL: URL { return URL(string: ServerInfo.baseApiUrl)! }
    public var path: String {
        switch self {
        case .all(let uri),
             .create(let uri, _, _, _, _, _):
            return "/projects/\(uri)/memberships"
        case .get(let uri, let membershipId),
             .update(let uri, let membershipId, _, _, _, _, _),
             .delete(let uri, let membershipId):
            return "/projects/\(uri)/memberships/\(membershipId)"
        case .sponsorship(let uri, let membershipId, _),
             .cancelSponsorship(let uri, let membershipId):
            return "/projects/\(uri)/memberships/\(membershipId)/sponsorship"
        case .getSponsoredMembership(let uri):
            return "/projects/\(uri)/memberships/sponsorship"
        case .uploadThumbnail(let uri):
            return "/projects/\(uri)/memberships/thumbnail"
        }
    }
    public var method: Moya.Method {
        switch self {
       case  .all,
             .get,
             .getSponsoredMembership:
            return .get
        case .create,
             .sponsorship:
            return .post
        case .update:
            return .put
        case .uploadThumbnail:
            return .patch
        case .delete,
             .cancelSponsorship:
            return .delete
        }
    }
    public var sampleData: Data {
        switch self {
        case .all:
            return jsonSerializedUTF8(json: [MembershipViewResponse.sampleData()])
        case .get,
             .create,
             .update:
            return jsonSerializedUTF8(json: MembershipViewResponse.sampleData())
        case .uploadThumbnail:
            return jsonSerializedUTF8(json: StorageAttachmentViewResponse.sampleData())
        case .delete,
             .cancelSponsorship:
            return jsonSerializedUTF8(json: DefaultViewResponse.sampleData())
        case .sponsorship:
            return jsonSerializedUTF8(json: SponsorshipViewResponse.sampleData())
        case .getSponsoredMembership:
            return jsonSerializedUTF8(json: SponsorshipViewResponse.sampleData())
        }
    }
    public var task: Task {
        switch self {
        case .all,
             .get,
             .delete,
             .cancelSponsorship,
             .getSponsoredMembership:
            return .requestPlain
        case .uploadThumbnail(_, let image):
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return .requestPlain
            }
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "file", fileName: "user.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .create(_, let name, let description, let thumbnail, let sponsorLimit, let price),
             .update(_, _, let name, let description, let thumbnail, let sponsorLimit, let price):
            var param: [String: Any] = [:]
            param["name"] = name
            param["price"] = price
            if let description = description {
                param["description"] = description
            }
            if let sponsorLimit = sponsorLimit {
                param["sponsorLimit"] = sponsorLimit
            }
            if let thumbnail = thumbnail {
                param["thumbnail"] = thumbnail
            }
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .sponsorship(_, _, let sponsorshipPrice):
            var param: [String: Any] = [:]
            param["sponsorshipPrice"] = sponsorshipPrice
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    public var headers: [String: String]? {
        switch self {
        case .uploadThumbnail:
            return ServerInfo.getMultipartFormDataHeader()
        default:
            return ServerInfo.getCustomHeader()
        }
    }
}

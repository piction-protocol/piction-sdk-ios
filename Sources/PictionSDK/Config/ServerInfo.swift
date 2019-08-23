//
//  ServerInfo.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

final class ServerInfo {
    static let devApiUrl = "api-stg.piction.network"
    static let liveApiUrl = "api.piction.network"

    enum stageType: Int {
        case dev = 0
        case live = 1

        var bundleId: String {
            switch self {
            case .dev:
                return "com.pictionnetwork.piction-test"
            default:
                return "com.pictionnetwork.piction"
            }
        }
    }

    static var stage: stageType {
        var infoDictionary: [AnyHashable: Any] = Bundle.main.infoDictionary!
        let appID: String = infoDictionary["CFBundleIdentifier"] as! String

        if appID == stageType.dev.bundleId {
            return .dev
        } else {
            return .live
        }
    }

    static var baseApiUrl: String {
        if stage == .dev {
            return "https://\(devApiUrl)"
        } else {
            return "https://\(liveApiUrl)"
        }
    }

    static func getCustomHeader() -> [String: String] {
        let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"]

        return [
            "X-Auth-Token": PictionManager.getToken,
            "X-App-Version": (appVersion as AnyObject).description,
            "X-Device-Udid": PictionManager.getDeviceUUID,
            "X-Device-Platform": "ios",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
    }

    static func getMultipartFormDataHeader() -> [String: String] {
        let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"]

        return [
            "X-Auth-Token": PictionManager.getToken,
            "X-App-Version": (appVersion as AnyObject).description,
            "X-Device-Udid": PictionManager.getDeviceUUID,
            "X-Device-Platform": "ios",
            "Accept": "*/*",
            "Content-Type": "multipart/form-data"
        ]
    }
}

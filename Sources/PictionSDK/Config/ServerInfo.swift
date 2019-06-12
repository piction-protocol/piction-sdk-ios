//
//  ServerInfo.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation

final class ServerInfo {
    static let apiUrl = "api-iro.piction.network"

    static var baseApiUrl: String {
        return "http://\(apiUrl)"
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

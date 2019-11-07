//
//  PictionManager.swift
//  PictionSDK
//
//  Created by jhseo on 17/05/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import Foundation
import KeychainAccess

public class PictionManager {
    public static var isLogin: Bool {
        return getToken != ""
    }

    public static var getToken: String {
        let keychain = Keychain(service: ServerInfo.baseApiUrl)
        let token: String? = keychain["AccessToken"]

        return token ?? ""
    }

    public static func logout() {
        removeToken()
    }

    public static func setToken(_ token: String) {
        let keychain = Keychain(service: ServerInfo.baseApiUrl)
        keychain["AccessToken"] = token
//        UserDefaults.standard.set(token, forKey: "AccessToken")
    }

    static func removeToken() {
        let keychain = Keychain(service: ServerInfo.baseApiUrl)
        keychain["AccessToken"] = ""
//        UserDefaults.standard.set("", forKey: "AccessToken")
    }

    static var getDeviceUUID: String {
        let keychain = Keychain(service: ServerInfo.baseApiUrl)
        var uuid: String? = keychain["UUID"]

        if uuid == nil || uuid == "" {
            let uuidRef: CFUUID = CFUUIDCreate(nil)
            let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)

            uuid = NSString(string: uuidStringRef) as String

            keychain["UUID"] = uuid ?? ""
        }
        return uuid!
    }
}


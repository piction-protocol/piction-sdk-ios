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
        return UserDefaults.standard.string(forKey: "AccessToken") ?? ""
    }

    public static func logout() {
        removeToken()
    }

    static func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "AccessToken")
    }

    static func removeToken() {
        UserDefaults.standard.set("", forKey: "AccessToken")
    }

    static var getDeviceUUID: String {
        let keychain = Keychain(service: ServerInfo.apiUrl)
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


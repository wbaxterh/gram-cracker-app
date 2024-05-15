//
//  UserManager.swift
//  GramCracker
//
//  Created by Wes Huber on 5/14/24.
//

import Foundation
import KeychainAccess

class UserManager {
    static let shared = UserManager()
    private let keychain = Keychain(service: "com.yourapp.identifier")

    var userEmail: String? {
        get { UserDefaults.standard.string(forKey: "userEmail") }
        set { UserDefaults.standard.set(newValue, forKey: "userEmail") }
    }

    var userToken: String? {
        get { try? keychain.get("userToken") }
        set {
            guard let token = newValue else {
                try? keychain.remove("userToken")
                return
            }
            try? keychain.set(token, key: "userToken")
        }
    }

    private init() {}

    func logOut() {
        // Remove user email from UserDefaults
        UserDefaults.standard.removeObject(forKey: "userEmail")
        
        // Remove user token from Keychain
        try? keychain.remove("userToken")
    }
}

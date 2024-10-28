//
//  UserSettings.swift
//  Levels
//
//  Created by Matthias Felix on 29.09.2023.
//

import Foundation
import SwiftUI

@Observable
class UserSettings {
    /*
    static let shared = UserSettings()
    var name: String = ""
    var nickName: String = ""
    var alwaysUseDarkMode: Bool = false
    
    private init() {}
    */
    
    
    static let shared = UserSettings()

    private init() {}

    static let userDefaultsKeyName = "levels.user-settings.name"
    static let userDefaultsKeyNickname = "levels.user.settings.nickname"
    static let userDefaultsKeyUserId = "levels.user-settings.userId"

    var name: String {
        get {
            // TODO
            return UserDefaults.standard.string(forKey: UserSettings.userDefaultsKeyName) ?? ""
        }
        set {
            // TODO
            UserDefaults.standard.set(newValue, forKey: UserSettings.userDefaultsKeyName)
        }
    }
    var nickname: String {
        get {
            // TODO
            return UserDefaults.standard.string(forKey: UserSettings.userDefaultsKeyNickname) ?? ""
        }
        set {
            // TODO
            UserDefaults.standard.set(newValue, forKey: UserSettings.userDefaultsKeyNickname)
        }
    }
    var userId: UUID {
        // TODO
        // If there is no UUID stored in UserDefaults, create one and store it.
        // Otherwise, just return the stored UUID.
        return .init()
    }

    var alwaysUseDarkMode: Bool {
            get {
                // Retrieve the stored value for dark mode or return false if not set
                return UserDefaults.standard.bool(forKey: "alwaysUseDarkMode")
            }
            set {
                // Store the new value for dark mode in UserDefaults
                UserDefaults.standard.set(newValue, forKey: "alwaysUseDarkMode")
            }
        }
}

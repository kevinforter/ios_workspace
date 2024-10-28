//
//  SettingsView.swift
//  Levels
//
//  Created by Kevin Forter on 08.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var userSettings = UserSettings.shared
    
    @AppStorage("levels.user-settings.name") private var name: String = ""
    @AppStorage("levels.user-settings.nickname") private var nickname: String = ""
    @AppStorage("alwaysUseDarkMode") private var alwaysUseDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User")) {
                    TextField("Username", text: $name)
                    TextField("Nickname", text: $nickname)
                }
                
                Section(header: Text("Erscheinungsbild")) {
                    Toggle("Immer Dark Mode verwenden", isOn: $alwaysUseDarkMode)
                }
                .preferredColorScheme(userSettings.alwaysUseDarkMode ? .dark : nil)
            }
            .navigationTitle("Einstellungen")
        }
    }
}

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

#Preview {
    SettingsView()
}

//
//  SettingsView.swift
//  Levels
//
//  Created by Kevin Forter on 08.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var userSettings = UserSettings.shared
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User")) {
                    TextField("Username", text: $userSettings.name)
                    TextField("Nickname", text: $userSettings.nickName)
                }
                
                Section(header: Text("Erscheinungsbild")) {
                    Toggle("Immer Dark Mode verwenden", isOn: $userSettings.alwaysUseDarkMode)
                }
                .preferredColorScheme(userSettings.alwaysUseDarkMode ? .dark : nil)
            }
            .navigationTitle("Einstellungen")
        }
    }
}

@Observable
class UserSettings {
    static let shared = UserSettings()
    var name: String = ""
    var nickName: String = ""
    var alwaysUseDarkMode: Bool = false
    
    private init() {}
}

#Preview {
    SettingsView()
}

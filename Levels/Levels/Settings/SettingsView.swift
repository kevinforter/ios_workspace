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
    //@AppStorage("alwaysUseDarkMode") private var alwaysUseDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User")) {
                    TextField("Username", text: $name)
                    TextField("Nickname", text: $nickname)
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

#Preview {
    SettingsView()
}

//
//  LevelsApp.swift
//  Levels
//
//  Created by Kevin Forter on 25.09.2024.
//

import SwiftUI

@main
struct LevelsApp: App {
    @State private var userSettings = UserSettings.shared
    @State private var levelState = LevelState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userSettings)
                .environment(levelState)
                .preferredColorScheme(userSettings.alwaysUseDarkMode ? .dark : nil)
                .modelContainer(SwiftDataManager.shared.modelContainer)
        }
    }
}

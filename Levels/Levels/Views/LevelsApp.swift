//
//  LevelsApp.swift
//  Levels
//
//  Created by Kevin Forter on 25.09.2024.
//

import SwiftUI
import SwiftData

@main
struct LevelsApp: App {
    @State private var userSettings = UserSettings.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userSettings)
                .modelContainer(SwiftDataManager.shared.modelContainer)
        }
    }
}

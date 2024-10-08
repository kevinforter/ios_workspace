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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userSettings)
        }
    }
}

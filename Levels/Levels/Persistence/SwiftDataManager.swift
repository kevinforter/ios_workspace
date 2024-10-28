//
//  SwiftDataManager.swift
//  Levels
//
//  Created by Matthias Felix on 14.10.2023.
//

import Foundation
import SwiftData

@MainActor class SwiftDataManager {
    static let shared = SwiftDataManager()

    let modelContainer = try! ModelContainer(for: LevelAttempt.self)

    private init() {}

    // TODO:
    // Write a saveAttempt() function that uses the modelContainer's
    // mainContext to store (insert) the new attempt
}

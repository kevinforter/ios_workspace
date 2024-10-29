//
//  User.swift
//  Levels
//
//  Created by Nicolas Märki on 10.09.2024.
//

import Foundation

struct User: Codable {
    let id: UUID
    let name: String
    let nickname: String
}

extension User {
    var imageUrl: URL {
        URL(string: "https://levels-ws.fly.dev/users/\(id)/image")!
    }
}

struct RankedUser: Identifiable {
    let user: User
    let attempts: [LevelAttempt]

    var id: UUID { user.id }

    var successCount: Int { attempts.filter(\.successful).count }
}

struct LevelUpdate: Encodable {
    let title: String
}

struct UserUpdate: Encodable {
    let name: String
    let nickname: String
}

struct LevelAttemptProxy: Codable {
    let id: UUID
    let userId: UUID
    let levelId: String
    let successful: Bool
    let time: TimeInterval
    let start: Date
    
    // Initialize from LevelAttempt
    init(from attempt: LevelAttempt) {
        self.id = attempt.id
        self.userId = attempt.userId
        self.levelId = attempt.levelId
        self.successful = attempt.successful
        self.time = attempt.time
        self.start = attempt.start
    }
    
    // Convert to LevelAttempt
    func toLevelAttempt() -> LevelAttempt {
        LevelAttempt(id: id, userId: userId, levelId: levelId, successful: successful, time: time, start: start)
    }
}


/*
// LevelAttemptProxy for loadAttempts
struct LevelAttemptProxy: Decodable {
    let id: UUID
    let userId: UUID
    let levelId: String
    let successful: Bool
    let time: TimeInterval
    let start: Date
    
    func toLevelAttempt() -> LevelAttempt {
        LevelAttempt(id: id, userId: userId, levelId: levelId, successful: successful, time: time, start: start)
    }
}

// UserAttemptProxy for uploadAttempts
struct UserAttemptProxy: Encodable {
    let id: UUID
    let userId: UUID
    let levelId: String
    let successful: Bool
    let time: TimeInterval
    let start: Date

    // Make sure this initializer includes all properties
    init(from attempt: LevelAttempt) {
        self.id = attempt.id
        self.userId = attempt.userId
        self.levelId = attempt.levelId
        self.successful = attempt.successful
        self.time = attempt.time
        self.start = attempt.start
    }
} */

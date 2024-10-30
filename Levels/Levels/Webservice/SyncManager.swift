//
//  Networking.swift
//  Levels
//
//  Created by Nicolas Märki on 22.10.2023.
//

import Foundation
import SwiftData

@Observable @MainActor
class SyncManager {
    static let shared = SyncManager()
    private init() {
    }

    var ranking: [RankedUser] = []

    private let baseUrl = URL(string: "https://levels-ws.fly.dev")!

    func updateRanking() async throws {
        let attempts = try await loadAttempts()
        storeAttempts(attempts)

        let users = try await loadUsers()
        setRanking(attempts: attempts, users: users)
    }

    func addAttempt(_ attempt: LevelAttempt) async throws {
        // TODO: 1. Send updates
        // Ensure, that the user and the level are known to the backend
        // by calling updateUser and updateLevel
        // This should happen in parallel
        try await updateUser(userId: attempt.userId)
        try await updateLevel(attempt: attempt)

        // TODO: 2. Send attempt
        // After sending both updates, the attempt can be uploaded
        try await uploadAttempt(attempt)

        // TODO: 3. Update Ranking
        // Ensure ranking includes latest attempt
        try await updateRanking()
    }

    private func loadAttempts() async throws -> [LevelAttempt] {
        // TODO: Load attempts
        // Send a GET request to https://levels-ws.fly.dev/attempts
        // Decode the result as LevelAttempts
        // NOTE: SwiftData objects are not decodable
        // Either implement the protocol manually or create a proxy struct
        
        // URL Construct
        let attemptURL = URL(string: "/attempts", relativeTo: baseUrl)!
        var request = URLRequest(url: attemptURL)
        request.httpMethod = "GET"
        
        // Decode the result as LevelAttempts
        let (data, _) = try await URLSession.shared.data(for: request)
        let attemptProxies = try JSONDecoder().decode([LevelAttemptProxy].self, from: data)

        return attemptProxies.map { $0.toLevelAttempt() }
    }

    private func storeAttempts(_ attempts: [LevelAttempt]) {
        for attempt in attempts {
            SwiftDataManager.shared.saveNewAttempt(attempt)
        }
    }

    private func loadUsers() async throws -> [User] {
        // TODO: Load users
        // Send a GET request to https://levels-ws.fly.dev/users
        // Decode the result as Users
        let usersURL = URL(string: "/users", relativeTo: baseUrl)!
        var request = URLRequest(url: usersURL)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let users = try JSONDecoder().decode([User].self, from: data)
        
        return users
    }

    private func setRanking(attempts: [LevelAttempt], users: [User]) {
        // TODO: Update ranking
        // Create ranked users by aggregating attempts with matching userId's
        // Sort by successCount
        
        // Dictionary to store userId and their corresponding attempts
        var userAttempts: [UUID: [LevelAttempt]] = [:]
        
        // Aggregate attempts by userId
        for attempt in attempts {
            userAttempts[attempt.userId, default: []].append(attempt)
        }
        
        // Create and sort a list of RankedUser objects
        var rankings: [RankedUser] = []
        
        for user in users {
            let attemptsForUser = userAttempts[user.id] ?? []
            rankings.append(RankedUser(user: user, attempts: attemptsForUser))
        }
        
        // Sort by successCount in descending order
        rankings.sort { $0.successCount > $1.successCount }
        
        // Update Rankings
        self.ranking = rankings
    }

    private func uploadAttempt(_ attempt: LevelAttempt) async throws {
        // TODO: Upload attempt
        // Send a POST request to https://levels-ws.fly.dev/attempts
        // A request is sent by loading data, but ignoring the result
        // The request body should be a decoded `UserUpdate`
        // Ensure that the header field Content-Type is set to application/json
        // NOTE: SwiftData objects are not encodable
        // Either implement the protocol manually or create a proxy struct
        
        // URL construct
        let attemptURL = URL(string: "/attempts", relativeTo: baseUrl)!
        var request = URLRequest(url: attemptURL)
        request.httpMethod = "POST"
        
        // Header field Content-Type is set to application/json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert `LevelAttempt` to `LevelAttemptProxy` and encode to JSON
        let attemptProxy = LevelAttemptProxy(from: attempt)
        request.httpBody = try JSONEncoder().encode(attemptProxy)
        
        // Send the request, ignoring the result
        _ = try await URLSession.shared.data(for: request)
    }

    private func updateLevel(attempt: LevelAttempt) async throws {
        // TODO: Upload attempt
        // Send the level name for a given level id
        // as a PUT request to https://levels-ws.fly.dev/levels/{LEVEL_ID}
        // A request is sent by loading data, but ignoring the result
        // The request body should be an encoded `LevelUpdate`
        // Ensure that the header field Content-Type is set to application/json
        
        // GET User First
        let levelsURL = URL(string: "/levels/\(attempt.levelId)", relativeTo: baseUrl)!
        var getRequest = URLRequest(url: levelsURL)
        getRequest.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: getRequest)
        let level = try JSONDecoder().decode(LevelUpdate.self, from: data)
        
        // URL Construct
        var request = URLRequest(url: levelsURL)
        request.httpMethod = "PUT"
        
        // Header field Content-Type is set to application/json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // convert LevelAttempt to levelUpdate
        let levelUpdate = LevelUpdate(title: level.title)
        let jsonData = try JSONEncoder().encode(levelUpdate)
        request.httpBody = jsonData
        
        // Send the request, ignoring the result
        _ = try await URLSession.shared.data(for: request)
    }

    private func updateUser(userId: UUID) async throws  {
        // TODO: Upload attempt
        // Send name and nickname for given user id
        // as a PUT request to https://levels-ws.fly.dev/users/{USER_ID}
        // A request is sent by loading data, but ignoring the result
        // The request body should be an encoded `UserUpdate`
        // Ensure that the header field Content-Type is set to application/json
        
        // GET User First
        let usersURL = URL(string: "/users/\(userId)", relativeTo: baseUrl)!
        var getRequest = URLRequest(url: usersURL)
        getRequest.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: getRequest)
        let user = try JSONDecoder().decode(User.self, from: data)
        
        // URL Construct
        var request = URLRequest(url: usersURL)
        request.httpMethod = "PUT"
        
        // Header field Content-Type is set to application/json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Header and field Content-Type is set to application/json
        let userUpdate = UserUpdate(name: user.name, nickname: user.nickname)
        let jsonData = try JSONEncoder().encode(userUpdate)
        request.httpBody = jsonData
        
        // Send the request, ignoring the result
        _ = try await URLSession.shared.data(for: request)
    }

}

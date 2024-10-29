//
//  RankingListView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct RankingListView: View {
    @State private var syncManager = SyncManager.shared
    @State private var rankedUsers: [RankedUser] = []
    
    var body: some View {
        NavigationStack {
            List(rankedUsers) { rankedUser in
                RankingPlayerView(
                    firstName: rankedUser.user.name,
                    codeName: "The \(rankedUser.user.nickname)",
                    score: "\(rankedUser.successCount)",
                    profileImageUrl: rankedUser.user.imageUrl
                )
            }
            .navigationBarTitle("Ranking List")
            .task {
                await loadRankings()
            }
            .refreshable {
                await loadRankings()
            }
        }
        
        /*
         NavigationStack {
         List {
         RankingPlayerView(firstName: "Kevin", codeName: "The Student", score: "1000")
         RankingPlayerView(firstName: "Elia", codeName: "The Designer", score: "900")
         RankingPlayerView(firstName: "Jovan", codeName: "The Salesman", score: "800")
         }
         .navigationBarTitle("Ranking List")
         }
         */
    }
    
    private func loadRankings() async {
        do {
            try await syncManager.updateRanking()
                        DispatchQueue.main.async {
                            self.rankedUsers = syncManager.ranking
                        }
        } catch {
            print("Failed to load rankings: \(error)")
        }
    }
}

#Preview {
    RankingListView()
}

//
//  RankingListView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct RankingListView: View {
    var body: some View {
        NavigationStack {
        List {
            RankingPlayerView(firstName: "Kevin", codeName: "The Student", score: "1000")
            RankingPlayerView(firstName: "Elia", codeName: "The Designer", score: "900")
            RankingPlayerView(firstName: "Jovan", codeName: "The Salesman", score: "800")
        }
        .navigationBarTitle("Ranking List")
        }
    }
}

#Preview {
    RankingListView()
}
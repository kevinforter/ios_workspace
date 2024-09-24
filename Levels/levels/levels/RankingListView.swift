//
//  RankingListView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct RankingListView: View {
    let firstName: String
    let codeName: String
    let score: String
    var body: some View {
        HStack {
            HStack {
                Image(ImageResource.player)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .clipShape(Circle())
                    .shadow(radius : 10)
                VStack (alignment: .leading) {
                    Text(firstName)
                        .font(.headline)
                    Text(codeName)
                        .font(.caption)
                }
            }
            .padding()
            Spacer()
            Text(score)
                .padding()
        }
    }
}

#Preview {
        NavigationStack {
        List {
            RankingListView(firstName: "Kevin", codeName: "The Student", score: "1000")
            RankingListView(firstName: "Elia", codeName: "The Designer", score: "900")
            RankingListView(firstName: "Jovan", codeName: "The Salesman", score: "800")
        }
        .navigationBarTitle("Ranking List")
    }
}

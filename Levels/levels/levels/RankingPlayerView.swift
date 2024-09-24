//
//  RankingPlayerView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct RankingPlayerView: View {
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
                    Text("Kevin")
                        .font(.headline)
                    Text("The Student")
                        .font(.caption)
                }
            }
            .padding()
            Spacer()
            Text("1000")
                .padding()
        }
    }
}

#Preview {
    RankingPlayerView(firstName: "Kevin", codeName: "The Student", score: "1000")
}

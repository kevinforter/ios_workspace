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
    let profileImageUrl: URL
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: profileImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView() // Displays a loading indicator while the image is loading
                }
                .frame(width: 50, height: 50)

                /*
                Image(ImageResource.player)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .clipShape(Circle())
                    .shadow(radius : 10)
                */
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

/*
#Preview {
    RankingPlayerView(firstName: "Kevin", codeName: "The Student", score: "1000")
}
*/

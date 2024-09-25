//
//  LevelDetailView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct LevelDetailView: View {
    let solved: String
    let failed: String
    let likes: String
    var body: some View {
        ScrollView {
            Image(ImageResource.level)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, minHeight: 0)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(2, contentMode: .fill)
                .padding()
            HStack {
                VStack {
                    Text("Solved")
                    Text(solved)
                        .font(.title)
                        .bold()
                }
                VStack {
                    Text("Failed")
                    Text(failed)
                        .font(.title)
                        .bold()
                    
                }
                Spacer()
                VStack {
                    Image(systemName: "heart")
                        .imageScale(.large)
                    Text(likes)
                        .textScale(.secondary)
                }
            }
            .padding()
            VStack (alignment: .leading) {
                Text("Das Erste Rätsel")
                    .font(.title)
                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut")
            }
            .padding()
            .background(Material.regular)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5)
        }
        .background {
            Image(ImageResource.level)
                .blur(radius: 20)
                .opacity(0.2)
        }
    }
}

#Preview {
    LevelDetailView(solved: "25", failed: "9", likes: "8")
}

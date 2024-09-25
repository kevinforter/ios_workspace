//
//  LevelDetailView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct LevelDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                        Text("25")
                            .font(.title)
                            .bold()
                    }
                    VStack {
                        Text("Failed")
                        Text("9")
                            .font(.title)
                            .bold()
                        
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "heart")
                            .imageScale(.large)
                        Text("8")
                            .textScale(.secondary)
                    }
                }
                .padding()
                VStack (alignment: .leading) {
                    Text("Das Erste Rätsel")
                        .font(.title)
                    Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut")
                    Text("Von ").font(.caption) + Text("Kevin").bold()
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Material.regular)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 5)
                .padding()
            }
        }
        .background {
            Image(ImageResource.level)
                .blur(radius: 20)
                .opacity(0.2)
        }
    }
}

#Preview {
    LevelDetailView()
}

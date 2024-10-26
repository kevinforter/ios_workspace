//
//  LevelDetailView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct LevelDetailView: View {
    @State var showLevel: Bool = false
    @Environment(\.dismiss) private var dismiss
    var level: any Level
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                level.titleImage
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
                VStack {
                    Button {
                        showLevel = true
                    } label: {
                        HStack {
                            Image(systemName: "play")
                                .font(.title2)
                                .bold()
                            Text("Level Starten")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(100)
                        .shadow(color: .black.opacity(0.3), radius: 5)
                    }
                }
                .frame(maxWidth: .infinity)
                VStack (alignment: .leading) {
                    Text(level.title)
                        .font(.title)
                    Text(level.description)
                    Text("Von ").font(.caption) + Text(level.author).bold()
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
            level.titleImage
                .blur(radius: 20)
                .opacity(0.2)
        }
        .navigationTitle(level.title)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showLevel) {
            NavigationStack {
                AnyView(erasing: level) // Erase type for the view
            }
        }
        //.fullScreenCover(isPresented: $showLevel, content: { HangmanLevel() })
        //.fullScreenCover(isPresented: $showLevel, content: { HangmanLevelView(showLevel: $showLevel) })
    }
}


#Preview {
    LevelDetailView(level: TextLevel())
}

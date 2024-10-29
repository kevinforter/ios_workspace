//
//  LevelDetailView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct LevelDetailView: View {
    //@State var showLevel: Bool = false
    //@Environment(\.dismiss) private var dismiss
    
    @Environment(LevelState.self) private var levelState
    var level: any Level
    var body: some View {
        @Bindable var levelState = levelState
        
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
                
                /*
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
                 */
                Button {
                    levelState.startLevel(level)
                } label: {
                    Label("Level starten", systemImage: "play")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 35.0)
                                .fill(Color.black)
                                .shadow(radius: 10)
                        }
                        .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(level.title)
                        .font(.title)
                    Text(level.description)
                    (Text("Von ") + Text(level.author).bold()).font(.caption)
                    LevelAttemptDetailsView(level: level)
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
        .fullScreenCover(item: $levelState.current) { currentLevel in
            NavigationStack {
                AnyView(erasing: currentLevel.level)
                    .toolbar {
                        Button("Abbrechen") {
                            Task {
                                await levelState.finish(successful: false)
                            }
                        }
                    }
            }
        }
        
        /*
         .fullScreenCover(isPresented: $showLevel) {
         NavigationStack {
         AnyView(erasing: level) // Erase type for the view
         }
         }
         */
        //.fullScreenCover(isPresented: $showLevel, content: { HangmanLevel() })
        //.fullScreenCover(isPresented: $showLevel, content: { HangmanLevelView(showLevel: $showLevel) })
    }
}


#Preview {
    LevelDetailView(level: TextLevel())
}

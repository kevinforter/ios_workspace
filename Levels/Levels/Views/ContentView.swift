//
//  ContentView.swift
//  Levels
//
//  Created by Kevin Forter on 25.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
        HStack {
            HStack {
                Image(systemName: "person")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
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
         */
        //LevelDetailView();
        TabView {
            LevelsOverview()
            .tabItem { Label("Levels", systemImage: "checklist") }
            RankingListView()
            .tabItem { Label("Ranking", systemImage: "star.fill") }
            SettingsView()
            .badge(2)
            .tabItem { Label("Einstellungen", systemImage: "gear") }
        }
    }
}

#Preview {
    ContentView()
}

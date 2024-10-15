//
//  LevelsOverview.swift
//  Levels
//
//  Created by Kevin Forter on 08.10.2024.
//

import SwiftUI

struct LevelsOverview: View {
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ] // Create a 2-column grid layout
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(LevelProvider.allLevels.indices, id: \.self) { index in
                            let level = LevelProvider.allLevels[index]
                            
                            NavigationLink(destination: LevelDetailView(level: level)) {
                                LevelsOverviewItemView(level: level)
                            }
                            .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Levels")
            }
    }
}

#Preview {
    LevelsOverview()
}

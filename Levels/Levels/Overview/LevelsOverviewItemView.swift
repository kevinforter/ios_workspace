//
//  LevelsOverviewItemView.swift
//  Levels
//
//  Created by Kevin Forter on 09.10.2024.
//

import SwiftUI

struct LevelsOverviewItemView: View {
    var level: any Level
    var body: some View {
        VStack {
            level.titleImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
            
            Text(level.title)
                .lineLimit(1)
            
            Text("Von ").font(.caption) + Text(level.author).bold()
                .font(.caption)
        }
    }
}

#Preview {
    LevelsOverviewItemView(level: TextLevel())
}

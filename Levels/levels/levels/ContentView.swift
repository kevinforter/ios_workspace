//
//  ContentView.swift
//  levels
//
//  Created by Kevin Forter on 24.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}

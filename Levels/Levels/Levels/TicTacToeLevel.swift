//
//  TicTacToeLevel.swift
//  Levels
//
//  Created by Kevin Forter on 15.10.2024.
//

import SwiftUI

struct TicTacToeLevel: Level {
    
    let id: String = "levels.hangman"
    let title: String = "TicTacToe"
    let author: String = "Kevin"
    let description: String = "Hier kommt das ultimative Duell: TicTacToe – Das epische Kräftemessen der X’e und O’s!"
    let titleImage: Image = Image(ImageResource.levelImage4)
    
    let col = Array(repeating: GridItem(.flexible()), count: 3)
    
    @Environment(\.dismiss) private var dismiss
    
    enum Player {
        case X, O
    }
    
    @State var board:[Player?] = Array(repeating: nil, count: 9)
    @State var currentPlayer:Player = .X
    
    func tabTabbed(i:Int) {
        if board[i] == nil {
            board[i] = currentPlayer
        }
        
        currentPlayer = (currentPlayer == .X) ? .O : .X
    }
    
    func textLabel(i:Int) -> String {
        if let player = board[i] {
            return player == .X ? "X" : "O"
        }
        return ""
    }
    
    func reset() {
        board = Array(repeating: nil, count: 9)
        currentPlayer = .X
    }
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding(.vertical)
            
            Spacer()
            
            VStack {
                Text("Current Player:")
                    .padding(.bottom)
                HStack {
                    Text("Player 1 (X)")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(.white)
                        .border(.black)
                        .cornerRadius(4)
                        .padding(.leading)
                    
                    Text("Player 2 (O)")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(.white)
                        .border(.black)
                        .cornerRadius(4)
                        .padding(.trailing)
                }
            }
            .padding()
            
            LazyVGrid(columns: col, content: {
                ForEach(0..<9) { i in
                    Text(textLabel(i: i))
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 100)
                        .background(.gray)
                        .cornerRadius(8)
                        .onTapGesture {
                            tabTabbed(i: i)
                        }
                    
                }
            })
            .padding()
            
            Button(action: {
                reset()
            }, label: {
                Text("Reset")
            })
            
            Spacer()
        }
        
        .toolbar {
            Button("Schliessen") {
                dismiss()
            }
        }
    }
}

#Preview {
    TicTacToeLevel()
}

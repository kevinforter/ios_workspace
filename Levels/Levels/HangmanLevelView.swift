//
//  HangmanLevelView.swift
//  Levels
//
//  Created by Matthias Felix on 22.09.2023.
//

import SwiftUI

private let asciiHangman = [
        """
           +-------+
           |
           |
           |
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |
           |
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |       |
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |      -|
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |      -|-
           |
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |      -|-
           |      /
           |
        ==============
        """
        ,
        """
           +-------+
           |       |
           |       0
           |      -|-
           |      / \\
           |
        ==============
        """]

private let wordList = [
    "Blumen",
    "Drache",
    "Ernten",
    "Fallen",
    "Felsen",
    "Ferien",
    "Fische",
    "Fliege",
    "Gabeln",
    "Galgen",
    "Garage",
    "Gebote",
    "Kissen",
    "Kugeln",
    "Lachen",
    "Laufen",
    "Mutter",
    "Narren",
    "Orange",
    "Palast",
    "Pfanne",
    "Planen",
    "Quelle",
    "Sonnen",
    "Steuer",
    "Teller",
    "Wasser",
    "Wolken",
]

struct HangmanLevelView: View {
    @Binding var showLevel: Bool
    @State var remainingTries: Int = 7
    @State var guessedLetters: Set<Character> = []
    @State var text: String = ""
    private let wordToGuess: [Character] = wordList.randomElement()!.uppercased().map { $0 }

    // Computed Property für das berechnete Wort
    private var calculatedWord: [Character] {
        wordToGuess.map { guessedLetters.contains($0) ? $0 : "_" }
    }
    
    func evaluateGuess() {
        // Versuche den ersten Buchstaben aus der Textvariable zu entnehmen
        if let guessedChar = text.first?.uppercased().first {
            // Prüfen, ob der Buchstabe nicht im Wort ist und nicht bereits geraten wurde
            if !wordToGuess.contains(guessedChar) && !guessedLetters.contains(guessedChar) {
                remainingTries -= 1 // Einen Versuch abziehen
            }
            // Buchstabe in guessedLetters hinzufügen
            guessedLetters.insert(guessedChar)
        }
        // Text zurücksetzen
        text = ""
    }
    
    var body: some View {
        VStack {
            Button {
                showLevel = false
            } label: {
                Text("Schliessen")
            }
            .frame(maxWidth: .infinity,
                   alignment: .trailing)
            .padding(.trailing, 8)
            
            Text("Hangman")
                .font(.largeTitle)
            
            Spacer().frame(height: 10)
            
            VStack {
                Text(asciiHangman[remainingTries])
                    .monospaced()
                    .font(.system(size: 28))
                    .padding(7)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.yellow.opacity(0.7)]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .cornerRadius(10)
            
            VStack (alignment: .leading) {
                Text("Verbleibende Versuche: \(remainingTries)")
                Text("Bereits geraten: \(guessedLetters.map { "\($0)" }.joined(separator: " "))")
                if calculatedWord == wordToGuess {
                    Text("🎉Du hast gewonnen!🎉")
                        .foregroundStyle(.green)
                        .bold()
                } else if remainingTries == 0 {
                    Text("👎Du hast verloren!👎")
                        .foregroundStyle(.red)
                        .bold()
                    Text("Das Wort war: \(wordToGuess.map { "\($0)"}.joined())")
                        .foregroundStyle(.red)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Material.regular)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding()
            
            HStack {
                ForEach(Array(calculatedWord.enumerated()), id: \.offset) { idx, c in
                    Text(String(c))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 60)
                        .font(.largeTitle)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(c == "_" ? Color.red : Color.green, lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)

            HStack {
                Text("Buchstabe:")
                
                TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 25)
                
                Button {
                    evaluateGuess()
                } label: {
                    Text("Raten")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(10)
            
            Spacer()
        }
    }
}

#Preview {
    HangmanLevelView(showLevel: .constant(true))
}

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
            
            // Berechnetes Wort anzeigen
            HStack {
                ForEach(calculatedWord, id: \.self) { letter in
                    Text(String(letter))
                        .font(.largeTitle)
                        .padding()
                }
            }
                        
            Text("Remaining Tries: \(remainingTries)")
                .font(.title)

            // Eingabefeld für das Raten eines Buchstabens
            TextField("Rate einen Buchstaben", text: $text, onCommit: {
                evaluateGuess()
                // Auswertung nach Eingabe
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            // TODO: Game UI
            Spacer()
        }
    }
}

#Preview {
    HangmanLevelView(showLevel: .constant(true))
}

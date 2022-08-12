//
//  ContentView.swift
//  Shared
//
//  Created by Jaylen Smith on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var items = ["🪨", "📜", "✂️"].shuffled()
    
    @State private var completedQuestions = 0
    @State private var score = 0
    
    @State private var playerWantsToWin: Bool = false
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        NavigationView {
            VStack {
                ItemList(items: $items, correctAnswer: $correctAnswer)
            }.navigationTitle("Rock, Paper, Scissors..")
        }
    }
}

struct ItemList: View {
        
    @State private var isCorrectAnswer = false
    
    @Binding var items: [String]
    @Binding var correctAnswer: Int
    
    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) {number in
                Button {
                    if number == correctAnswer {
                        isCorrectAnswer = true
                    }
                    shuffling()
                } label: {
                    ItemCard(item: items[number])
                }
            }
        }.alert("That's correct!", isPresented: $isCorrectAnswer) {
        } message: {
            Text("The computer guessed \(items[correctAnswer]) as well")
        }
    }
    
    mutating func shuffling() {
        items.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    struct ItemCard: View {
                
        let item: String
        
        var body: some View {
            ZStack {
                Color.red.opacity(0.35)
                Text(item)
                    .font(.system(size: 100))
            }.frame(width: UIScreen.main.bounds.width-75, height: 200)
                .cornerRadius(30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

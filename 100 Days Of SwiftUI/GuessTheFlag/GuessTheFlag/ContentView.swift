//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jaylen on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var answer: Int = 0
    @State private var score: Int = 0
    @State private var question: Int = 1
    
    @State private var activateFade = false
    @State private var activateRotation = false
    @State private var activateOffset = false
    @State private var activateRefreshOffset = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flags")
                    .bigBlueTitle()
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(number: number, activateFade: $activateFade, countries: countries)
                        }
                        .opacity(answer != number ? activateFade ? 0.25 : 1 : 1)
                            .rotationEffect(Angle(degrees: answer == number ? activateRotation ? 360 : 0 : 0), anchor: .center)
                            .offset(x: answer != number ? activateOffset ? UIScreen.main.bounds.width : 0 : 0)
                            .offset(x: activateRefreshOffset ? UIScreen.main.bounds.width : 0)
                    }.onDisappear {
                        withAnimation {
                            activateRefreshOffset = false
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Question \(question) of 8")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                withAnimation {
                    activateFade = false
                    activateRotation = false
                    activateOffset = false
                }
                askQuestion()
            }
        } message: {
            Text("That's the flag of \(countries[answer])")
            Text("Your score is \(score)")
        }
        .alert("End of game!", isPresented: $endOfGame) {
            Button("Again!") {
                reset()
                shuffle()
                withAnimation {
                    activateRefreshOffset = true
                }
            }
        } message: {
            Text("You have reached the end!\nYou scored: \(score) out of 8!")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            answer = number
            score += 1
            withAnimation {
                activateFade = true
                activateRotation = true
                activateOffset = true
            }
        } else {
            scoreTitle = "False"
            answer = number
            withAnimation {
                activateFade = true
                activateRotation = true
                activateOffset = true
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        if question != 8 {
            shuffle()
            question += 1
        } else if question == 8 {
            endOfGame.toggle()
        }
    }
    
    func shuffle() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        withAnimation {
            activateFade = false
            activateRefreshOffset = false
        }
        question = 0
        score = 0
        answer = 0
        askQuestion()
    }
}

struct FlagImage: View {
    
    var number: Int
    
    @State private var isTapped = false
    
    @Binding var activateFade: Bool
    
    //Since countries are shuffled...
    var countries: [String]
    
    var body: some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
           
        
    }
}

extension View {
    func bigBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

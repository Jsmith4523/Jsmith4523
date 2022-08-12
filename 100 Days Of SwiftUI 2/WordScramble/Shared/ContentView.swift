//
//  ContentView.swift
//  Shared
//
//  Created by Jaylen on 7/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var secondaryAlertButton = ""
    @State private var secondaryAlertClosure: () = ()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.none)
                    
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        usedWords.removeAll()
                    } label: {
                        Image(systemName: "trash")
                    }
                    Button(role: .none) {
                        startGame()
                        usedWords.removeAll()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            })
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showAlert) {
                Button("OK") {}
                if secondaryAlertButton != nil && secondaryAlertButton != "" {
                    Button(secondaryAlertButton) {
                        let _ = secondaryAlertClosure
                        print(rootWord)
                    }
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard answer.count > 0 else { return }
        
        guard isSameWord(word: answer) else {
           wordError(title: "That's the same word!!", message: "You cannot used \(answer)", secondaryButtonTitle: nil, secondaryButtonClosure: nil)
            return
        }
        
//        guard isLessThanThreeDigits(word: answer) else {
//            wordError(title: "Less than three characters!", message: "Try using words with more than three characters. Or, you can shuffle your word pressing 'Shuffle'", secondaryButtonTitle: "Shuffle", secondaryButtonClosure: startGame())
//            return
//        }
        
        guard (isOriginal(word: answer)) else {
            wordError(title: "Word is used", message: "Be more original", secondaryButtonTitle: nil, secondaryButtonClosure: nil)
            return
        }
        
        guard containsInts(word: answer) else {
            wordError(title: "Numbers are not allowed", message: "You cannot spell words using numbers!", secondaryButtonTitle: nil, secondaryButtonClosure: nil)
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You cant spell that word from \(rootWord)!", secondaryButtonTitle: nil, secondaryButtonClosure: nil)
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up", secondaryButtonTitle: nil, secondaryButtonClosure: nil)
            return
        }
        
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                self.newWord.removeAll()
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func containsInts(word: String) -> Bool {
        
        let intCheck = Int(word)
        
        if ((intCheck?.isMultiple(of: 1)) != nil) {
            return false
        }
        return true
    }
    
    func isSameWord(word: String) -> Bool {
        return !(word == rootWord)
    }
    
    func isLessThanThreeDigits(word: String) -> Bool {
        return word.count > 3
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String, secondaryButtonTitle: String?, secondaryButtonClosure: ()?) {
        errorTitle = title
        errorMessage = message
        showAlert.toggle()
        
        if let secondaryButtonClosure = secondaryButtonClosure {
            print("at if let..")
            self.secondaryAlertClosure = secondaryButtonClosure
        }
        
        if let secondaryButtonTitle = secondaryButtonTitle {
            self.secondaryAlertButton = secondaryButtonTitle
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

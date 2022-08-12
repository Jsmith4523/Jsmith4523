//
//  ContentView.swift
//  BetterRest
//
//  Created by Jaylen on 6/28/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
        
    @State private var scheduledBetime = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var coffeIntake: String {
        return coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups"
    }
    
    var coffeeCups = { (count: Int) -> String in
        return count == 1 ? "1 cup of coffee" : "\(count) cups of coffee"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section {
                    Picker(coffeIntake, selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { int in
                            Text(coffeeCups(int))
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                }
                Section {
                    Text("Your scheduled betime is \(calculateBedtime())")
                    
                } header: {
                    Text("Scheduled Betime")
                }

            }.navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0 * 60 * 60)
            let minute = (components.minute ?? 0 * 60)
            
            
            let perdiction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - perdiction.actualSleep
                        
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "There was a problem calculating bedtime"
            showAlert.toggle()
        }
        showAlert = true
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

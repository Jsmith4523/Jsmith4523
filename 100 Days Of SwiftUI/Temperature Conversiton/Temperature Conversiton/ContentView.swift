//
//  ContentView.swift
//  Temperature Conversiton
//
//  Created by Jaylen on 6/14/22.
//

import SwiftUI

let units = [
    "celsius",
    "fahrenheit",
    "kelvin"
]

struct ContentView: View {
    
    @State private var inputTemp: Double = 0.0
    @State private var inputUnit: String = "fahrenheit"
    @State private var outputUnit: String = "celsius"
    
    @FocusState private var inputTempIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Units", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Input")
                }
                Section {
                    Picker("Units", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Output")
                }
                Section {
                    TextField("Input", value: $inputTemp, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputTempIsFocused)
                } header: {
                    Text("Convert...")
                }
                
                Section {
                    Text("\(unitConverter().formatted())")
                } header: {
                    Text("Output")
                }

            }.navigationTitle("Temperature Conversion")
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button {
                                inputTempIsFocused.toggle()
                            } label: {
                                Text("Done")
                            }
                        }
                    }
                }
        }
    }
    
    func unitConverter() -> Double {
    
        var result: Double = 0.0
        
        if inputUnit == "fahrenheit" && outputUnit == "celsius" {
            result = 5/9*(inputTemp-32)
        } else if inputUnit == "celsius" && outputUnit == "fahrenheit" {
            result = 9/5*inputTemp+32
        } else if inputUnit == "kelvin" && outputUnit == "celsius" {
            result = inputTemp-273.15
        } else if inputUnit == "celsius" && outputUnit == "kelvin" {
            result = inputTemp+273.15
        } else if inputUnit == "fahrenheit" && outputUnit == "kelvin" {
            result = (inputTemp-32)*5/9+273.15
        } else if inputUnit == "kelvin" && outputUnit == "fahrenheit" {
            result = (inputTemp-273.15)*9/5+32
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

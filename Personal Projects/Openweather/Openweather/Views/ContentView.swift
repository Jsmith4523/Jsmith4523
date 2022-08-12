//
//  ContentView.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack {
            Text("\(weatherVM.temp)")
            
            HStack {
                Text("HI: \(weatherVM.hi)")
                Text("HI: \(weatherVM.low)")
            }
            
            Text("\(weatherVM.description)")
            
            Button {
                weatherVM.fetchWeather()
                weatherVM.fetchTemperatures()
            } label: {
                Text("Update")
            }

        }.onAppear {
            weatherVM.fetchWeather()
            weatherVM.fetchTemperatures()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

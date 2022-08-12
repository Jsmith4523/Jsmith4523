//
//  Openweather_3_0App.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/6/22.
//

import SwiftUI

@main
struct Openweather_3_0App: App {
    
    @ObservedObject var vm = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            Root(vm: self.vm)
        }
    }
}

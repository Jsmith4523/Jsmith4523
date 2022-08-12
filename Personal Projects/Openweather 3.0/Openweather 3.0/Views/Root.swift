//
//  ContentView.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/6/22.
//

import SwiftUI
import Foundation
import Drawer

struct Root: View {
    
    @ObservedObject var vm: WeatherViewModel
    
    @State private var heights: [CGFloat] = [CGFloat(UIScreen.main.bounds.height/2), CGFloat(UIScreen.main.bounds.height-215)]
    
    var body: some View {
        ZStack {
            Background()
            Drawer(heights: $heights) {
                ZStack {
                    DrawerContent(vm: vm)
                }.background(Material.thickMaterial).cornerRadius(20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Root(vm: WeatherViewModel())
            .preferredColorScheme(.light)
    }
}

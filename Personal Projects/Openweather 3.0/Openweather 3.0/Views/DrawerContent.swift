//
//  Drawer.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/8/22.
//

import Foundation
import SwiftUI

struct DrawerContent: View {
    
    @ObservedObject var vm: WeatherViewModel
    
    @State private var rotate: Bool = false
    @State private var rotateAmount: Double = 360
    
    var body: some View {
        VStack {
            Text(vm.hi)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    HStack {
                        Text("Bowie State University")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Button {
                            vm.fetchHourlyForcase()
                            vm.fetchWeather()
                            withAnimation {
                                if rotateAmount == -360 {
                                    rotateAmount = 360
                                } else {
                                    rotateAmount = -360
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .rotationEffect(Angle(degrees: rotateAmount))
                        }
                    }.padding(.horizontal)
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer()
                                ForEach(vm.hourly, id: \.?.dt) { hour in
                                    HourlyForecastMember(hour: hour!, vm: self.vm)
                                }
                                Spacer()
                            }
                        }
                    } header: {
                        HStack {
                            Text("Hourly Forecast")
                                .font(.caption2)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer()
                                ForEach(vm.daily, id: \.?.sunrise) { daily in
                                    DailyForecastMember(daily: daily!, vm: self.vm)
                                }
                            }
                            Spacer()
                        }
                    } header: {
                        HStack {
                            Text("\(vm.daily.count)-day Forecast")
                                .font(.caption2)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                    }
                }.onAppear {
                    vm.fetchHourlyForcase()
                    vm.fetchWeather()
                    vm.fetchDaily()
                }
                Spacer()
                Button {
                    vm.fetchDaily()
                    vm.fetchHourlyForcase()
                } label: {
                    Text("Try again")
                }
            }
        }
    }
}

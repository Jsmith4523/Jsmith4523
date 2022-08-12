//
//  WeatherViewModel.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    
    
    @Published var temperature: Temperatures?
    @Published var weather: [Weather?] = [Weather(id: 2343, description: "Unavaliabe")]
    
    @Published var hourly: [Hourly?] = [Hourly(dt: 10002984839, temp: 0.65, weather: [Weather(id: 0234, description: "nope!")])]
    @Published var daily: [Daily?] = [Daily(dt: 23434342, sunrise: 223343432, sunset: 223232432, temp: Temp(day: 32.3, min: 221.22, max: 223.3), weather: [Weather(id: 434323, description: "Unavaliable")])]
    
    @Published var alert: Bool = false
    
    @Published var gradient: [Color] = [.gray, .gray]
    @Published var symbol: Image = Image("")
    
    @Published var isShowingForecastView: Bool = false
    @Published var showFailureAlert: Bool = false
    
    @AppStorage ("selectedDegree") var selectedDegree = "Farenheit"
    
    var temp: String {
        guard let temp = temperature?.temp else {
            return "--"
        }
        return "\(temperatureConverter(value: temp, toConversion: .farenheit).formatted())"
    }
    
    var hi: String {
        guard let hi = temperature?.temp_max else {
            return "--"
        }
        return "\(temperatureConverter(value: hi, toConversion: .farenheit).formatted())"
    }

    var low: String {
        guard let low = temperature?.temp_min else {
            return "--"
        }
        return "\(temperatureConverter(value: low, toConversion: .farenheit).formatted())"
    }
    
    var description: String {
        return (weather.first??.description)!
    }
    
    var houred: String {
        guard let temp = hourly.first else {
            return "Failed"
        }
        return "This is: \(temp ?? Hourly(dt: 100209323, temp: 0.044, weather: [Weather(id: 0234, description: "nope!")]))"
    }
    
    
    func fetchWeather() {
        WeatherService().getTemperatures { result in
            switch result {
            case .success(let weather):
                print("Success")
                DispatchQueue.main.async {
                    self.showFailureAlert = false
                    self.temperature = weather
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showFailureAlert = true
                }
                print("error with temps: \(error.rawValue)")
            }
        }
    }
    
    func fetchTemperatures() {
        WeatherService().getWeather { result in
            switch result {
            case .success(let temp):
                print("success 2")
                DispatchQueue.main.async {
                    self.weather = temp
                }
            case .failure(let error):
                print("error with weather: \(error.rawValue)")
            }
        }
    }
    
    func fetchHourlyForcase() {
        WeatherService().getHourly { result in
            switch result { 
            case .success(let hourly):
                print("We got hourly")
                DispatchQueue.main.async {
                    withAnimation {
                        self.hourly = hourly
                    }
                }
            case .failure(let error):
                print("Error with hourly forecase: \(error.rawValue)")
            }
        }
    }
    
    func fetchDaily() {
        WeatherService().getDaily { result in
            switch result {
            case .success(let daily):
                print("We got daily")
                DispatchQueue.main.async {
                    withAnimation {
                        self.daily = daily
                    }
                }
            case .failure(let error):
                print("Error with daily: \(error.rawValue)")
            }
        }
    }
    
    func changeAppearance(_ description: String) -> Image {
        switch description {
        case "clear sky":
            return Image(systemName: "sparkles")
        case "few clouds":
            return Image(systemName: "cloud")
        case "scattered clouds":
            return  Image(systemName: "cloud.fill")
        case "broken clouds":
            return Image(systemName: "cloud")
        case "overcast clouds":
            return Image(systemName: "smoke.fill")
        case "shower rain":
            return Image(systemName: "cloud.snow.fill")
        case "rain":
            return Image(systemName: "cloud.rain.fill")
        case "light rain": 
            return Image(systemName: "cloud.rain.fill")
        case "moderate rain":
            return Image(systemName: "cloud.rain")
        case "thunderstorm":
           return Image(systemName: "cloud.bolt.rain.fill")
        case "heavy intensity rain":
            return Image(systemName: "cloud.hail.fill")
        case "very heavy rain":
            return Image(systemName: "cloud.heavyrain.fill")
        case "snow":
            return Image(systemName: "snowflake")
        case "mist":
            return Image(systemName: "cloud.fog")
        default:
            print("No symbol or gradient provided for \(String(describing: description))")
            return Image(systemName: "")
        }
    }
}

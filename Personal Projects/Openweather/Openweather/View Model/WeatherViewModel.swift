//
//  WeatherViewModel.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation


class WeatherViewModel: ObservableObject {
    
    @Published var temperature: Temperatures?
    @Published var weather: [Weather?] = [Weather(description: "Not avaliable!")]
    
    var temp: String {
        guard let temp = temperature?.temp else {
            return "0"
        }
        return temperatureConverter(value: temp, toConversion: .farenheit).formatted()
    }
    
    var hi: String {
        guard let hi = temperature?.temp_max else {
            return "0"
        }
        return temperatureConverter(value: hi, toConversion: .farenheit).formatted()
    }

    var low: String {
        guard let low = temperature?.temp_min else {
            return "0"
        }
        return temperatureConverter(value: low, toConversion: .farenheit).formatted()
    }
    
    var description: String {
        return (weather.first??.description)!
    }
    
    func fetchWeather() {
        WeatherService().getTemperatures { result in
            switch result {
                case .success(let weather):
                    print("Success")
                DispatchQueue.main.async {
                    self.temperature = weather
                }
            case .failure(let error):
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
}

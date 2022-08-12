//
//  WeatherModel.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Temperatures
}

struct TemperatureResponse: Decodable {
    let weather: [Weather]
}

struct Weather: Decodable {
    let description: String
}

struct Temperatures: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

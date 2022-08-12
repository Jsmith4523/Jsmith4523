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

struct HourlyResponse: Decodable {
    let hourly: [Hourly]
}

struct DailyResponse: Decodable {
    let daily: [Daily?]
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

//{"dt":1659830400,"temp":305.72,"feels_like":308.86,"pressure":1016,"humidity":51,"dew_point":294.27,"uvi":0.15,"clouds":33,"visibility":10000,"wind_speed":2.94,"wind_deg":184,"wind_gust":5.77,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0}

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct Temperatures: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}


//{"dt":1659895200,"sunrise":1659871979,"sunset":1659921054,"moonrise":1659907620,"moonset":1659853860,"moon_phase":0.33,"temp":{"day":308.79,"min":296.63,"max":309.64,"night":303.99,"eve":306.52,"morn":296.63},"feels_like":{"day":311.58,"night":304.96,"eve":307.76,"morn":297.36},"pressure":1018,"humidity":40,"dew_point":293.1,"wind_speed":5.07,"wind_deg":149,"wind_gust":11.46,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":93,"pop":0.41,"uvi":9.45}


struct Daily: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
}

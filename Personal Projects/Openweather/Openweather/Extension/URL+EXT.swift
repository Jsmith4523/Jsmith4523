//
//  String+EXT.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation

extension URL {
    static func urlWeather() -> URL? {
        //OpenWeatherAPI is weird. Typing "Bowie" does not work for "Bowie, MD". Instead, it goes to "Bowie, US"
        //Using Crofton since its no more than two miles away from Bowie so :)
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Crofton&appid=558166551dad6eee451e1f75d712978c") else {
            return nil
        }
        return url
    }
}

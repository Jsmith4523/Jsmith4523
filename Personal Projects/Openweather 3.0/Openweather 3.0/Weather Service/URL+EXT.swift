//
//  String+EXT.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation

extension URL {
    static func urlWeather() -> URL? {
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=39.01872&lon=-76.76024&appid=558166551dad6eee451e1f75d712978c") else {
            return nil
        }
        return url
    }
    static func urlCampusNews() -> URL? {
        guard let url = URL(string: "https://www.bowiestate.edu/about/news/") else {
            return nil
        }
        return url
    }
}

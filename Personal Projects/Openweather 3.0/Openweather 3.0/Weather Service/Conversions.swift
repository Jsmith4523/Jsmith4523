//
//  Conversions.swift
//  Studently
//
//  Created by Jaylen on 7/20/22.
//

import Foundation

enum Conversion {
    case kelvin, farenheit
}

func temperatureConverter(value: Double,toConversion conversion: Conversion) -> Int {
        
    switch conversion {
    case .kelvin:
        return Int(value)
    case .farenheit:
        return Int((value-273.15)*9/5+32)
    }
}

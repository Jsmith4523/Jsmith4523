//
//  HourlyForecast.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/8/22.
//

import Foundation
import SwiftUI

struct HourlyForecastMember: View {
    
    let hour: Hourly
    
    var unwrappedTemp: String {
        return "\(Int((hour.temp-273.15)*9/5+32))˚F"
    }
    
    var timeInterval: String {
        let time = hour.dt
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        formatter.dateFormat = "MM-dd'T'HH:mm:ss.SSS'Z'"
        return "\(Date(timeIntervalSince1970: TimeInterval(time)).formatted(date: .omitted, time: .shortened))"
    }
    
    var isCurrentDate: Bool {
        let date = hour.dt
        
        let formatted = Date(timeIntervalSince1970: TimeInterval(date)).formatted(date: .numeric, time: .omitted)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "MM/dd"
        
        switch formatted {
        case "\(Date.now.formatted(date: .numeric, time: .omitted))":
            return true
        default:
            return false
        }
    }
    
    var isLaterThroughTheWeek: Bool {
        let date = hour.dt
        
        let formatted = Date(timeIntervalSince1970: TimeInterval(date)).formatted(date: .numeric, time: .omitted)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "MM/dd"
        
        switch formatted {
        case "\(Date.now.addingTimeInterval(86400*2).formatted(date: .numeric, time: .omitted))":
            return true
        case "\(Date.now.addingTimeInterval(86400*3).formatted(date: .numeric, time: .omitted))":
            return true
        default:
            return false
        }
    }
    
    var isBehindTheCurrentDay: Bool {
        let date = hour.dt
        
        let formatted = Date(timeIntervalSince1970: TimeInterval(date)).formatted(date: .numeric, time: .omitted)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "MM/dd"
        
        switch formatted {
        case "\(Date.now.addingTimeInterval(-86400).formatted(date: .numeric, time: .omitted))":
            return true
        case "\(Date.now.addingTimeInterval(-86400*2).formatted(date: .numeric, time: .omitted))":
            return true
        case "\(Date.now.addingTimeInterval(-86400*3).formatted(date: .numeric, time: .omitted))":
            return true
        default:
            return false
        }
    }
    
    
    var date: String {
        let date = hour.dt
        let formatted = Date(timeIntervalSince1970: TimeInterval(date)).formatted(date: .numeric, time: .omitted)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "MM/dd"
        
        switch formatted {
        case "\(Date.now.formatted(date: .numeric, time: .omitted))":
            return "Today"
        case "\(Date.now.addingTimeInterval(86400).formatted(date: .numeric, time: .omitted))":
            return "Tomorrow"
        case "\(Date.now.addingTimeInterval(86400*2).formatted(date: .numeric, time: .omitted))":
            return "\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(date))))"
        case "\(Date.now.addingTimeInterval(-86400).formatted(date: .numeric, time: .omitted))":
            return "Yesterday"
        default:
            return "\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(date))))"
        }
    }
    
    
    @ObservedObject var vm: WeatherViewModel
    
    var body: some View {
        VStack {
            vm.changeAppearance(hour.weather.first!.description)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(uiColor: .white))
            Text(unwrappedTemp)
                .font(.system(size: 10))
                .fontWeight(.semibold)
                .foregroundColor(Int(unwrappedTemp) ?? 69 >= 100 ? .red : .white)
            Spacer()
                .frame(height: 3)
            Text(timeInterval)
                .font(.system(size: 7))
                .foregroundColor(Color(uiColor: .white))
            Spacer()
                .frame(height: 5)
            Text(date)
                .font(.system(size: 8))
                .bold()
                .foregroundColor(Color(uiColor: .white))
        }
        .padding()
        .foregroundColor(.white)
        .background(isCurrentDate ? .accentColor : isLaterThroughTheWeek ?  Color.accentColor.opacity(0.45) : isBehindTheCurrentDay ? Color(uiColor: .lightGray).opacity(0.75) : Color.accentColor.opacity(0.69) )
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

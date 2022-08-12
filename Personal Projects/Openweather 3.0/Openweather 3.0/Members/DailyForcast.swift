//
//  DailyForcast.swift
//  Openweather 3.0
//
//  Created by Jaylen on 8/8/22.
//

import Foundation
import SwiftUI

struct DailyForecastMember: View {
    
    let daily: Daily
        
    @ObservedObject var vm: WeatherViewModel
    
    var unwrappedDescription: String {
        return daily.weather.first!.description
    }
    
    var unwrappedTemp: String {
        return "\(Int((daily.temp.day-273.15)*9/5+32))˚F"
    }
    
    var unwrappedMax: String {
        return "\(Int((daily.temp.max-273.15)*9/5+32))"
    }
    
    var unwrappedMin: String {
        return "\(Int((daily.temp.min-273.15)*9/5+32))"
    }

    var formattedDate: String {
        
        let date = daily.dt
        
        let intervaledDate = Date(timeIntervalSince1970: TimeInterval(date))
    
        
        let formatted = intervaledDate.formatted(date: .numeric, time: .omitted)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        //Monday, Tuesday, Wednesday, Thursday...
        formatter.dateFormat = "EEEE"
        
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
    
    var isCurrentDate: Bool {
        let date = daily.dt
        
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
    
    var body: some View {
        ZStack {
            VStack {
                vm.changeAppearance(unwrappedDescription)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                HStack {
                    Text(unwrappedMax)
                        .font(.system(size: 10))
                    Divider()
                    Text(unwrappedMin)
                        .font(.system(size: 10))
                }
                .frame(height: 10)
                Text(unwrappedDescription)
                    .font(.system(size: 8))
                Spacer()
                    .frame(height: 5)
                Text(formattedDate)
                    .font(.system(size: 9))
                    .bold()
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(isCurrentDate ? Color(uiColor: .systemBlue).opacity(0.6) : Color.white, lineWidth: isCurrentDate ? 2.5 : 1))
            .padding(.vertical)
    }
}

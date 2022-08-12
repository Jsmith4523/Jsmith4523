//
//  WeatherService.swift
//  Openweather
//
//  Created by Jaylen on 7/20/22.
//

import Foundation

enum NetworkError: String, Error {
    case badUrl = "OpenWeather API URL invalid. Check URL+EXT and try again!"
    case noData = "OpenWeather API is providing no data. Check service and try again!"
    case decodingError = "There was an error decoding the data!"
}

final class WeatherService {
    
    func getTemperatures(completion: @escaping (Result<Temperatures?, NetworkError>) -> Void) {
        
        guard let url = URL.urlWeather() else {
            return completion(.failure(.badUrl))
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                        
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getWeather(completion: @escaping (Result<[Weather?], NetworkError>) -> Void) {
        guard let url = URL.urlWeather() else {
            return completion(.failure(.badUrl))
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let temperatureResponse = try? JSONDecoder().decode(TemperatureResponse.self, from: data)
                        
            if let temperatureResponse = temperatureResponse {
                completion(.success(temperatureResponse.weather))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getHourly(completion: @escaping (Result<[Hourly?], NetworkError>) -> Void) {
        guard let url = URL.urlWeather() else {
            return completion(.failure(.badUrl))
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let hourlyResponse = try? JSONDecoder().decode(HourlyResponse.self, from: data)
                        
            if let hourlyResponse = hourlyResponse {
                completion(.success(hourlyResponse.hourly))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getDaily(completion: @escaping (Result<[Daily?], NetworkError>) -> Void) {
        guard let url = URL.urlWeather() else {
            return completion(.failure(.badUrl))
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let dailyResponse = try? JSONDecoder().decode(DailyResponse.self, from: data)
                        
            if let dailyResponse = dailyResponse {
                completion(.success(dailyResponse.daily))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

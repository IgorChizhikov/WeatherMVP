//
//  WeatherModel.swift
//  WeatherMVP
//
//  Created by Игорь on 23.11.22.
//

import Foundation


// MARK: - Weather -

struct Weather: Codable {
    var city: String?
    var temperature: String?
    var weatherDescription: String?
    var weatherPerDay = WeatherPerDay()
    var forecast = Forecast()

    enum CodingKeys: String, CodingKey {
        case city, temperature
        case weatherDescription = "description"
        case weatherPerDay = "weather_per_day"
        case forecast
    }
    
    init(city: String? = "", temperature: String? = "", weatherDescription: String? = "") {
            self.city = city
            self.temperature = temperature
            self.weatherDescription = weatherDescription
        }
}

// MARK: - WeatherPerDay -

struct WeatherPerDay: Codable {
    let timestamp: String?
    let weatherType: String?
    let temperature: String?
    let sunset: Bool?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case weatherType = "weather_type"
        case temperature, sunset
    }
    init(timestamp: String? = "", weatherType: String? = "", temperature: String? = "", sunset: Bool? = false) {
        self.timestamp = timestamp
        self.weatherType = weatherType
        self.temperature = temperature
        self.sunset = sunset
    }
}


// MARK: - Forecast -

struct Forecast: Codable {
    let date: String?
    let minTemperature: Int?
    let maxTemperature: Int?
    let weatherType: String?

    enum CodingKeys: String, CodingKey {
        case date
        case minTemperature = "min_temperature"
        case maxTemperature = "max_temperature"
        case weatherType = "weather_type"
    }
    
    init(date: String? = "", minTemperature: Int? = 0, maxTemperature: Int? = 0, weatherType: String? = "") {
        self.date = date
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.weatherType = weatherType
    }
}

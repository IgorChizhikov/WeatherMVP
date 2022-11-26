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
    var weatherPerDay: [DayWeather] = []
    var forecast: [Forecast] = []

    enum CodingKeys: String, CodingKey {
        case city, temperature
        case weatherDescription = "description"
        case weatherPerDay = "weather_per_day"
        case forecast
    }
}

// MARK: - WeatherPerDay -

struct DayWeather: Codable {
    let timestamp: String?
    let weatherType: String?
    let temperature: String?
    let sunset: Bool?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case weatherType = "weather_type"
        case temperature, sunset
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

}

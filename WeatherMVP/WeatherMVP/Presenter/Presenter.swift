//
//  Presenter.swift
//  WeatherMVP
//
//  Created by Игорь on 23.11.22.
//

import Foundation
import UIKit


protocol WeatherPresenterDelegate: AnyObject {
    func presentCurrentWeather(weather: Weather)
    func presentWeatherPerDay(weather: [DayWeather])
    func presentForecast(weather: [Forecast])
}

typealias PresenterDelegate = WeatherPresenterDelegate & UIViewController

class WeatherPresenter{
    weak var delegate: PresenterDelegate?
    
    public func getWeatherData(){
        guard let url = Bundle.main.url(forResource: "TestTaskJSON", withExtension: "json") else {
            return
        }
        
            let decoder = JSONDecoder()
       
            do {
                let data = try Data(contentsOf: url)
                
                let weather = try decoder.decode(Weather.self, from: data)
                self.delegate?.presentCurrentWeather(weather: weather)
                
                let dayData = weather.forecast
                let weekData = weather.weatherPerDay
                
                self.delegate?.presentWeatherPerDay(weather: weekData)
                self.delegate?.presentForecast(weather: dayData)
                
            } catch {
                print(error.localizedDescription)
            }

    }
    
    public func setVeiwDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
}



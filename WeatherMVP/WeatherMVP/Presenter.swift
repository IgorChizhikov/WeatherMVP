//
//  Presenter.swift
//  WeatherMVP
//
//  Created by Игорь on 23.11.22.
//

import Foundation
import UIKit


protocol WeatherPresenterDelegate: AnyObject {
    func presentCurrentWeather(weather: [Weather])
    func presentWeatherPerDay(weather: [WeatherPerDay])
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
                
                let weather = try decoder.decode([Weather].self, from: data)
                self.delegate?.presentCurrentWeather(weather: weather)
                
                let weatherPerDay = try decoder.decode([WeatherPerDay].self, from: data)
                self.delegate?.presentWeatherPerDay(weather: weatherPerDay)
                
                let forecast = try decoder.decode([Forecast].self, from: data)
                self.delegate?.presentForecast(weather: forecast)
            } catch {
                print(error.localizedDescription)
            }

    }
    
    public func setVeiwDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
}



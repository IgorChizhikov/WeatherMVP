//
//  DateExtension.swift
//  WeatherMVP
//
//  Created by Игорь on 24.11.22.
//

import Foundation


extension Date {
    
    func stringToDate(_ string: String) -> Date {
        let inputString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.date(from: inputString)!
    }
   
    func shortDayName(_ date: Date) -> String {
        let inputDate = date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: inputDate)
    }

}

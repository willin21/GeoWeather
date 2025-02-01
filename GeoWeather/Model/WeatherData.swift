//
//  WeatherData.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation

struct WeatherData {
    let sections: [WeatherSection]
    
    struct City {
        let name: String
        let currentWeatherText: String?
    }
    
    struct Temperature {
        let current: String
        let highLow: String
    }
    
    struct HourCondition {
        let date: Date
        let title: String
        let subTitle: String
        let probabilityPrecipitation: String?
        let icon: String?
    }
    
    init(sections: [WeatherSection]) {
        self.sections = sections
    }
    
    static func activityIndicator() -> WeatherData {
        WeatherData(sections: [.activityIndicator])
    }
    
}

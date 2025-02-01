//
//  WeatherSection.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation
import UIKit

enum WeatherSection {
    case city(info: WeatherData.City)
    case temperature(info: WeatherData.Temperature)
    case dailyForecast(info: [WeatherData.HourCondition])
    case activityIndicator
    
    var cellClass: ReusableView.Type {
        switch self {
        case .city:
            return CityCollectionViewCell.self
        case .temperature:
            return TemperatureCollectionViewCell.self
        case .dailyForecast:
            return HourForecastCollectionViewCell.self
        case .activityIndicator:
            return ActivityIndicatorCollectionViewCell.self
        }
    }
    
    var numberOfItems: Int {
        switch self {
        case .city:
            return 1
        case .temperature:
            return 1
        case .dailyForecast(let info):
            return info.count
        case .activityIndicator:
            return 1
        }
    }
    
    var size: CGSize {
        switch self {
        case .city:
            return CGSize(width: 200, height: 90)
        case .temperature:
            return CGSize(width: 200, height: 140)
        case .dailyForecast:
            return CGSize(width: 60, height: 110)
        case .activityIndicator:
            return CGSize(width: 200, height: 300)
        }
    }
}

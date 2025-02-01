//
//  City.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

enum TemperatureUnit: String {
    case celsius = "ºC"
    case fahrenheit = "ºF"
    
    mutating func switchUnit() {
        switch self {
        case .celsius:
            self = .fahrenheit
        case .fahrenheit:
            self = .celsius
        }
    }
}

struct City: Codable, Equatable {
    let name: String
    let coordinate: Coordinate
    var region: String
    let id: Int
    let country: String
    let url: String
    
    var temperatureCelsius: Double?
    var temperatureString: String?
    
    struct Coordinate: Codable, Equatable {
        let latitude: Double
        let longitude: Double
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
    
    mutating func setTemperatureString(temperatureUnit: TemperatureUnit) {
        guard let temperatureCelsius = temperatureCelsius else {
            return
        }
        if temperatureUnit == .celsius {
            temperatureString = NumberFormatter.celsiusToString(celsius: temperatureCelsius)
        } else {
            temperatureString = NumberFormatter.fahrenheitToString(celsius: temperatureCelsius)
        }
    }
    
}

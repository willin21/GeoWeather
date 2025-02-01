//
//  City.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import Foundation

extension City {
        
    static var mockMiami: City {
        City(name: "Miami",
             coordinate: Coordinate.init(latitude: 25.761631885979096, longitude: -80.19382192061222),
             region: "Florida",
             id: 01,
             country: "United States of America",
             url: "miami-url",
             temperatureCelsius: 2557386,
             temperatureString: "2557386")
    }
    
    static var mockBarcelona: City {
        City(name: "Barcelona",
             coordinate: .init(latitude: 41.3851, longitude: 2.1734),
             region: "Catalonia",
             id: 02,
             country: "Spain",
             url: "barcelona-url",
             temperatureCelsius: 2557386,
             temperatureString: "2557386")
    }
}

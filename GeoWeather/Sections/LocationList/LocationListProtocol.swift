//
//  LocationListProtocol.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

protocol LocationListProtocol {
    var cities: [City] { get }
    
    var temperatureUnit: TemperatureUnit { get }
    
    func switchTemperatureUnit() throws
    func deleteCity(at index: Int) throws
    func presentCitySearch()
    func presentForecast(for city: City, query: String)
}

//
//  LocationListViewModel.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

struct LocationListViewModel: LocationListProtocol {
    
    var temperatureUnit: TemperatureUnit = .celsius
    
    private let navigationFrame: NavigationFrameProtocol
    
    init(navigationFrame: NavigationFrameProtocol) {
        self.navigationFrame = navigationFrame
    }
    
    var cities: [City] {
        FavouritesHelper.shared.getFavorites().map {
            var city = $0
            city.setTemperatureString(temperatureUnit: temperatureUnit)
            return city
        }
    }
    
    func deleteCity(at index: Int) throws {
        try FavouritesHelper.shared.deleteCity(at: index)
    }
   
    func switchTemperatureUnit() throws { }
    
    func presentCitySearch() {
        navigationFrame.presentSearchLocation()
    }
    
    func presentForecast(for city: City, query: String) {
        navigationFrame.presentForecast(for: city, query: query)
    }
}

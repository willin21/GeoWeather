//
//  LocationSearchViewModel.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

struct SearchLocationViewModel: SearchLocationProtocol {

    private var repository = WeatherRepository()
    
    private let navigationFrame: NavigationFrameProtocol
    
    var searchText = ""
    
    init(navigationFrame: NavigationFrameProtocol) {
        self.navigationFrame = navigationFrame
    }
    
    func searchLocation(query: String,
                  success: @escaping (_ result: [City]) -> Void,
                  errorMessage: @escaping (String) -> Void) {
        let weatherInput = WeatherInput(key: Preferences.weatherApiKey, query: query)
        
        repository.getSearch(model: weatherInput) { result in
            let cities = mapper(result)
            success(cities)
        } errorMessage: { error in
            errorMessage(error)
        }
    }
    
    private func mapper(_ response: [SearchResponse]) -> [City] {
        return response.map { weather -> City in
            City(name: weather.name,
                 coordinate: City.Coordinate(
                    latitude: weather.lat,
                    longitude: weather.lon),
                 region: weather.region,
                 id: weather.id,
                 country: weather.country,
                 url: weather.url)
        }
    }
    
    func didSelectCity(city: City) {
        navigationFrame.presentForecast(for: city, query: searchText)
    }
}

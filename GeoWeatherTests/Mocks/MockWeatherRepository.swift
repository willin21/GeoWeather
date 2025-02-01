//
//  MockWeatherRepository.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//
import XCTest
@testable import GeoWeather

class MockWeatherRepository: WeatherRepository {
    var shouldFail = false
    var searchResult: [City] = []
    var errorMessage: String = ""

    override func getSearch(model: WeatherInput, completion success: @escaping ([SearchResponse]) -> Void, errorMessage: @escaping (String) -> Void) {
        if shouldFail {
            errorMessage(self.errorMessage)
        } else {
            let response = searchResult.map { city in
                SearchResponse(id: city.id,
                               name: city.name,
                               region: city.region,
                               country: city.country,
                               lat: city.coordinate.latitude,
                               lon: city.coordinate.longitude,
                               url: city.url)
            }
            success(response)
        }
    }
}

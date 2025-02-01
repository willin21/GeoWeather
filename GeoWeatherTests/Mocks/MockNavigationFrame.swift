//
//  MockNavigationFrame.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import XCTest
@testable import GeoWeather

class MockNavigationFrame: NavigationFrameProtocol {
    var window: UIWindow = UIWindow()
    
    // Variables para verificar si los métodos fueron llamados
    var didCallPresentMainScreen = false
    var didCallPresentLocationList = false
    var didCallPresentSearchLocation = false
    var didCallPresentForecast = false
    var didCallDidPressCityListButton = false
    
    var lastPresentedCity: City?
    var lastQuery: String?
    
    func presentMainScreen() {
        didCallPresentMainScreen = true
    }
    
    func presentLocationList() {
        didCallPresentLocationList = true
    }
    
    func presentSearchLocation() {
        didCallPresentSearchLocation = true
    }
    
    func presentForecast(for city: City, query: String) {
        didCallPresentForecast = true
        lastPresentedCity = city
        lastQuery = query
    }
    
    func didPressCityListButton() {
        didCallDidPressCityListButton = true
    }
}

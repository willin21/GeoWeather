//
//  LocationListViewModelTests.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import XCTest
@testable import GeoWeather

final class LocationListViewModelTests: XCTestCase {
    
    var viewModel: LocationListViewModel!
    var mockNavigationFrame: MockNavigationFrame!
    var mockFavouritesHelper: MockFavouritesHelper!
    
    override func setUp() {
        super.setUp()
        mockNavigationFrame = MockNavigationFrame()
        mockFavouritesHelper = MockFavouritesHelper()
        viewModel = LocationListViewModel(navigationFrame: mockNavigationFrame)
    }
    
    func test_cities_returnsFavoritesWithTemperatureUnitApplied() {
        // Given
        let testCity = City.mockMiami
        mockFavouritesHelper.favorites = [testCity]
        
        // When
        let cities = viewModel.cities
        
        // Then
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, "Madrid")
    }
    
    func test_deleteCity_removesCitySuccessfully() {
        // Given
        mockFavouritesHelper.favorites = [City.mockMiami]
        
        // When
        XCTAssertNoThrow(try viewModel.deleteCity(at: 0))
    }
    
    func test_deleteCity_throwsErrorForInvalidIndex() {
        // Given
        mockFavouritesHelper.favorites = []
        
        // When & Then
        XCTAssertThrowsError(try viewModel.deleteCity(at: 0))
    }
    
    func test_presentCitySearch_callsNavigation() {
        // When
        viewModel.presentCitySearch()
        
        // Then
        XCTAssertTrue(mockNavigationFrame.didCallPresentSearchLocation)
    }
    
    func test_presentForecast_callsNavigationWithCorrectData() {
        // Given
        let testCity = City.mockBarcelona
        
        // When
        viewModel.presentForecast(for: testCity, query: "Barcelona")
        
        // Then
        XCTAssertTrue(mockNavigationFrame.didCallPresentForecast)
        XCTAssertEqual(mockNavigationFrame.lastPresentedCity?.name, "Barcelona")
    }
}

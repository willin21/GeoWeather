//
//  DetailForecastViewModelTests.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import XCTest
@testable import GeoWeather

final class DetailForecastViewModelTests: XCTestCase {
    
    var viewModel: DetailForecastViewModel!
    var mockNavigationFrame: MockNavigationFrame!
    var mockRepository: MockWeatherRepository!
    var mockFavouritesHelper: MockFavouritesHelper!
    var testCity: City!
    
    override func setUp() {
        super.setUp()
        testCity = City.mockMiami
        mockNavigationFrame = MockNavigationFrame()
        mockRepository = MockWeatherRepository()
        mockFavouritesHelper = MockFavouritesHelper()
        viewModel = DetailForecastViewModel(city: testCity, navitationFrame: mockNavigationFrame)
    }

    func test_getForecast_handlesError() {
        // Given
        let expectedError = "Network error"
        mockRepository.shouldFail = true
        mockRepository.errorMessage = expectedError

        let expectation = self.expectation(description: "Forecast should return an error")

        // When
        viewModel.getForecast(query: "Madrid", success: {
            XCTFail("Expected error but got success")
        }, errorMessage: { error in
            XCTAssertEqual(error, expectedError)
            expectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_isSaved_returnsCorrectValue() {
        // Given
        mockFavouritesHelper.favorites = [testCity]

        // When
        let isSaved = viewModel.isSaved

        // Then
        XCTAssertTrue(isSaved)
    }

    func test_saveCity_savesSuccessfully() {
        // When
        XCTAssertNoThrow(try viewModel.saveCity())

        // Then
        XCTAssertTrue(mockFavouritesHelper.didCallGetFavorites)
    }

    func test_didPressCityList_callsNavigation() {
        // When
        viewModel.didPressCityList()

        // Then
        XCTAssertTrue(mockNavigationFrame.didCallDidPressCityListButton)
    }
}

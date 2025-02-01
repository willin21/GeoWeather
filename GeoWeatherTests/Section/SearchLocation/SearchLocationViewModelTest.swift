//
//  SearchLocationViewModelTest.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import XCTest
import Combine
@testable import GeoWeather

final class SearchLocationViewModelTest: XCTestCase {
    private var detailForcastVM: DetailForecastViewModel!
    
    var viewModel: SearchLocationViewModel!
        var mockRepository: MockWeatherRepository!
        var mockNavigationFrame: MockNavigationFrame!

        override func setUp() {
            super.setUp()
            mockRepository = MockWeatherRepository()
            let window = UIWindow(frame: UIScreen.main.bounds)
            viewModel = SearchLocationViewModel(navigationFrame: NavigationFrame(window: window))
        }

        func test_searchLocation_successfulResponse() {
            // Given
            let expectedCities = [City.mockMiami]

            let expectation = self.expectation(description: "Search location should return valid results")

            // When
            viewModel.searchLocation(query: "Madrid", success: { cities in
                XCTAssertEqual(cities.count, expectedCities.count)
                XCTAssertEqual(cities.first?.name, "Madrid")
                expectation.fulfill()
            }, errorMessage: { _ in
                XCTFail("Expected success but received an error")
            })

            // Then
            waitForExpectations(timeout: 1.0, handler: nil)
        }

        func test_searchLocation_failureResponse() {
            // Given
            let expectedError = "Network error"
            mockRepository.shouldFail = true
            mockRepository.errorMessage = expectedError

            let expectation = self.expectation(description: "Search location should return an error")

            // When
            viewModel.searchLocation(query: "Madrid", success: { _ in
                XCTFail("Expected failure but received success")
            }, errorMessage: { error in
                XCTAssertEqual(error, expectedError)
                expectation.fulfill()
            })

            // Then
            waitForExpectations(timeout: 1.0, handler: nil)
        }

        func test_didSelectCity_shouldTriggerNavigation() {
            // Given
            let selectedCity = City.mockBarcelona

            // When
            viewModel.didSelectCity(city: selectedCity)

            // Then
            XCTAssertEqual(mockNavigationFrame.lastQuery, "Barcelona")
        }
    
}

//
//  DetailWeatherProtocol.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit
import Foundation

protocol DetailForecastProtocol {
    var dataSource: WeatherData { get }
        
    var isSaved: Bool { get }
    
    func saveCity() throws
    func didPressCityList()
    func getForecast(query: String, success: @escaping () -> Void, errorMessage: @escaping (String) -> Void)
}

protocol ForecastViewRepresentable: UICollectionViewCell {
    func configure(with section: WeatherSection, indexPath: IndexPath)
}

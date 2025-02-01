//
//  WeatherSection.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell, ForecastViewRepresentable {
    
    @IBOutlet private weak var cityName: UILabel!
    
    @IBOutlet private weak var conditions: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.accessibilityIdentifier = "CityNameLabel"
        conditions.accessibilityIdentifier = "ConditionsLabel"
        
        cityName.textColor = .black
        conditions.textColor = .black
        backgroundColor = .white
        
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        cityName.text = nil
        conditions.text = nil
    }
    
    func configure(with section: WeatherSection, indexPath: IndexPath) {
        if case let .city(info) = section {
            let city = info
            cityName.text = city.name
            conditions.text = city.currentWeatherText
        }
    }
}

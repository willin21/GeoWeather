//
//  WeatherSection.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit

final class TemperatureCollectionViewCell: UICollectionViewCell, ForecastViewRepresentable {
    
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var highLowTemperature: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        temperature.accessibilityIdentifier = "TemperatureLabel"
        highLowTemperature.accessibilityIdentifier = "HighLowTemperatureLabel"
        
        temperature.textColor = .black
        highLowTemperature.textColor = .black
        backgroundColor = .white
        
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        temperature.text = nil
        highLowTemperature.text = nil
    }
    
    func configure(with section: WeatherSection, indexPath: IndexPath) {
        if case let .temperature(info) = section {
            let temp = info
            temperature.text = temp.current
            highLowTemperature.text = temp.highLow
        }
    }
}

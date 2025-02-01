//
//  WeatherSection.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit

final class ActivityIndicatorCollectionViewCell: UICollectionViewCell, ForecastViewRepresentable {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(with section: WeatherSection, indexPath: IndexPath) {
        activityIndicator.startAnimating()
    }
}

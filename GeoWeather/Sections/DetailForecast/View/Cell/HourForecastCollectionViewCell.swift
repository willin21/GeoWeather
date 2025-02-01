//
//  WeatherSection.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit
import SDWebImage

final class HourForecastCollectionViewCell: UICollectionViewCell, ForecastViewRepresentable {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var probabilityPrecipitation: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.textColor = .black
        probabilityPrecipitation.textColor = .black
        subTitle.textColor = .black
        backgroundColor = .white
        
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        title.text = nil
        imageView.image = nil
        subTitle.text = nil
    }
    
    func configure(with section: WeatherSection, indexPath: IndexPath) {
        title.accessibilityIdentifier = "DailyForecastTitle_\(indexPath.row)"
        imageView.accessibilityIdentifier = "DailyForecastImageView_\(indexPath.row)"
        probabilityPrecipitation.accessibilityIdentifier = "DailyForecastPrecipitation_\(indexPath.row)"
        subTitle.accessibilityIdentifier = "DailyForecastSubtitle_\(indexPath.row)"
    
        if case let .dailyForecast(info) = section {
            let hourData = info[indexPath.row]
            
            title.text = hourData.title
            probabilityPrecipitation.text = hourData.probabilityPrecipitation
            subTitle.text = hourData.subTitle
            
            if let icon = hourData.icon {
                let urlImage = URL(string: "https:\(icon)")
                imageView.sd_setImage(with: urlImage, placeholderImage: UIImage(named: "questionmark"))
            }
        }
    }

}

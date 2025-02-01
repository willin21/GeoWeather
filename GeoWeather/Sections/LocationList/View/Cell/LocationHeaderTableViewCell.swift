//
//  CityListFooterView.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didPressWeatherButton()
    func didPressSearchButton()
}

final class LocationHeaderTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var magnitudeButton: UIButton!
    @IBOutlet private weak var weatherButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    
    weak var delegate: HeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .lightGray
        
        let weatherImage = UIImage(named: "ic_twc")
        weatherButton.setImage(weatherImage, for: .normal)
        searchButton.tintColor = .black
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func configure(for temperatureUnit: TemperatureUnit) {
        let title = TemperatureUnit.celsius.rawValue + " / " + TemperatureUnit.fahrenheit.rawValue
        let stringToColor = temperatureUnit.rawValue
        
        let range = (title as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString(string: title)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)

        magnitudeButton.setAttributedTitle(mutableAttributedString, for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func didPressWeatherButton(_ sender: Any) {
        delegate?.didPressWeatherButton()
    }
    
    @IBAction func didPressSearchButton(_ sender: Any) {
        delegate?.didPressSearchButton()
    }
}

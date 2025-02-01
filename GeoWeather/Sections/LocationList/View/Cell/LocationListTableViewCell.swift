//
//  LocationListTableViewCell.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var temperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetCell()
        
        title.textColor = .black
        subTitle.textColor = .black
        temperature.textColor = .black
        backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        title.text = nil
        subTitle.text = nil
        temperature.text = nil
    }
    
    func configure(with city: City) {
        title.text = city.name
        subTitle.text = city.region
        temperature.text = city.temperatureString
    }
}

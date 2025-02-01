//
//  String.swift
//  GeoWeather
//
//  Created by william niño on 31/01/25.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

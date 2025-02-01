//
//  DateFormatter.swift
//  GeoWeather
//
//  Created by william niño on 31/01/25.
//

import Foundation

extension DateFormatter {
    
    static let hour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        return formatter
    }()

    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        
        return formatter
    }()

}

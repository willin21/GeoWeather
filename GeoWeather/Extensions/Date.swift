//
//  Date.swift
//  GeoWeather
//
//  Created by william niño on 31/01/25.
//
import Foundation

extension Date {
    func setToHourString() -> String {
        var hour = DateFormatter.hour.string(from: self)
        
        if let hourInt = Int(hour) {
            
            if hourInt >= 12 {
                return hour + "PM"
            }
            
            if hourInt == 0 { hour = "12" }
        }
        
        return hour + "AM"
    }
}

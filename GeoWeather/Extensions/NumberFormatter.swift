//
//  NumberFormatter.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

extension NumberFormatter {
    
    static let noDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        return formatter
    }()
    
    static let percentage: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    static func celsiusToString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        guard let string = formatter.string(from: celsius as NSNumber) else {
            return "--"
        }
        
        return string + "°"
    }
    
    static func fahrenheitToString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        let measure = Measurement(value: celsius, unit: UnitTemperature.celsius)
        let fahrenheit = measure.converted(to: .fahrenheit).value
        guard let string = formatter.string(from: fahrenheit as NSNumber) else {
            return "--"
        }
        
        return string + "°"
    }
    
    static func temperatureString(celsius: Double?, unit: TemperatureUnit = .celsius) -> String {
        guard let value = celsius else {
            return "--"
        }
        switch unit {
        case .celsius:
            return celsiusString(celsius: value)
        case .fahrenheit:
            return fahrenheitString(celsius: value)
        }
    }
    
    static func celsiusString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        guard let string = formatter.string(from: celsius as NSNumber) else {
            return "--"
        }
        
        return string + "°"
    }
    
    static func fahrenheitString(celsius: Double) -> String {
        let formatter = NumberFormatter.noDecimal
        let measure = Measurement(value: celsius, unit: UnitTemperature.celsius)
        let fahrenheit = measure.converted(to: .fahrenheit).value
        guard let string = formatter.string(from: fahrenheit as NSNumber) else {
            return "--"
        }
        
        return string + "°"
    }
}

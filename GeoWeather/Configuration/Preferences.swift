//
//  Preferences.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

struct Preferences {
    private static var secrets: [String: String] = {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        return dict as! [String: String]
    }()
    
    static let weatherApiKey: String = secrets["WeatherAPIKey"]!
}

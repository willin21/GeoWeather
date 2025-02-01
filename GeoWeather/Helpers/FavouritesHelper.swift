//
//  FavouritesHelper.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import UIKit

class FavouritesHelper {
    
    static let shared = FavouritesHelper()
    
    func getFavorites() -> [City] {
        guard let data = UserDefaultsHelper.getObject(forKey: Constants.UserDefaults.saveFavoriteItems) else {
            return []
        }
        
        return (try? JSONDecoder().decode([City].self, from: data)) ?? []
    }
    
    func removeAllFavorites() {
        UserDefaultsHelper.removeObject(forKey: Constants.UserDefaults.saveFavoriteItems)
    }
    
    func save(city: City) throws {
        var cities = getFavorites()

        if let index = cities.firstIndex(of: city) {
            cities.remove(at: index)
            cities.insert(city, at: index)
        } else {
            cities.append(city)
        }
        
        try save(cities)
    }
    
    private func save(_ cities: [City]) throws {
        let data = try JSONEncoder().encode(cities)
        UserDefaultsHelper.saveObject(objectToSave: data, forKey: Constants.UserDefaults.saveFavoriteItems)
    }
    
    func isSaved(city: City) -> Bool {
        let cities = getFavorites()
        
        if let _ = cities.firstIndex(of: city) {
            return true
        }
        
        return false
    }
    
    func deleteCity(at index: Int) throws {
        var cities = getFavorites()
        cities.remove(at: index)
        try save(cities)
    }
}

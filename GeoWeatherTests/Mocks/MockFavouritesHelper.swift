//
//  MockFavouritesHelper.swift
//  GeoWeather
//
//  Created by william niño on 1/02/25.
//

import Foundation
@testable import GeoWeather

class MockFavouritesHelper {
    var favorites: [City] = []
    
    // Variables para verificar si los métodos fueron llamados
    var didCallGetFavorites = false
    var didCallDeleteCity = false
    var lastDeletedIndex: Int?
    
    func getFavorites() -> [City] {
        didCallGetFavorites = true
        return favorites
    }
    
    func deleteCity(at index: Int) throws {
        didCallDeleteCity = true
        lastDeletedIndex = index
        
        // Simular un error si el índice es inválido
        guard index >= 0 && index < favorites.count else {
            throw NSError(domain: "Invalid index", code: 1, userInfo: nil)
        }
        
        favorites.remove(at: index)
    }
}

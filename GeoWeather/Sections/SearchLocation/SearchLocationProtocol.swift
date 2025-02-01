//
//  LocationSearchProtocol.swift
//  GeoWeather
//
//  Created by william niño on 29/01/25.
//

import Foundation

protocol SearchLocationProtocol {
    func searchLocation(query: String, success: @escaping (_ result: [City]) -> Void, errorMessage: @escaping (String) -> Void)
    func didSelectCity(city: City)
}

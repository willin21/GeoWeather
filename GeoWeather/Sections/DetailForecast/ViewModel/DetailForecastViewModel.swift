//
//  DetailForecastViewModel.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import Foundation

class DetailForecastViewModel: DetailForecastProtocol {
    
    var dataSource: WeatherData
    
    var temperatureUnit: TemperatureUnit = .celsius
    
    private var city: City
    private var repository = WeatherRepository()
    private let navitationFrame: NavigationFrameProtocol
    
    required init(city: City,
                  navitationFrame: NavigationFrameProtocol) {
        self.city = city
        self.navitationFrame = navitationFrame
        self.dataSource = WeatherData(sections: [WeatherSection]())
    }
    
    func getForecast(query: String,
                     success: @escaping () -> Void,
                     errorMessage: @escaping (String) -> Void) {
        let weatherInput = WeatherInput(key: Preferences.weatherApiKey, query: query, days: 5)
        
        repository.getForecast(model: weatherInput) { result in
            self.dataSource = self.mapper(result)
            success()
        } errorMessage: { error in
            errorMessage(error)
        }
    }
    
    private func mapper(_ response: ForecastResponse) -> WeatherData {
        let city = WeatherData.City(
            name: city.name,
            currentWeatherText: response.current.condition.text?.capitalizingFirstLetter()
        )
        
        let forecastday = response.forecast.forecastday
        let maxTemp = forecastday.map { $0.day.maxtempC }.max() ?? 0
        let minTemp = forecastday.map { $0.day.mintempC }.max() ?? 0
        let hourlyLimited = forecastday.first?.hour
        
        let hourly = hourlyLimited?.map {
            WeatherData.HourCondition(
                date: $0.timeEpoch ?? Date(),
                title: ($0.timeEpoch ?? Date()).setToHourString(),
                subTitle: NumberFormatter.temperatureString(celsius: temperatureUnit == .celsius
                                                            ? $0.tempC
                                                            : $0.tempF,
                                                            unit: temperatureUnit),
                probabilityPrecipitation: NumberFormatter.percentage.string(from: ($0.chanceOfRain ?? 0) as NSNumber),
                icon: $0.condition.icon
            )
        }
        
        let temperature = NumberFormatter.temperatureString(celsius: temperatureUnit == .celsius
                                                                ? response.current.tempC
                                                                : response.current.tempF,
                                                            unit: temperatureUnit)
        
        let temperatureMax = NumberFormatter.temperatureString(celsius: maxTemp, unit: temperatureUnit)
        let temperatureMin = NumberFormatter.temperatureString(celsius: minTemp, unit: temperatureUnit)
        let temperatureData = WeatherData.Temperature(current: temperature, highLow: "H: \(temperatureMax)  L: \(temperatureMin)")
        
        self.city.temperatureString = temperature
        self.city.region = self.city.region
        
        return WeatherData(
            sections: [
                .city(info: city),
                .temperature(info: temperatureData),
                .dailyForecast(info: hourly ?? [WeatherData.HourCondition]())
            ]
        )
    }
    
    var isSaved: Bool {
        FavouritesHelper.shared.isSaved(city: city)
    }
    
    func saveCity() throws {
        try FavouritesHelper.shared.save(city: city)
    }
    
    func didPressCityList() {
        navitationFrame.didPressCityListButton()
    }
    
}

import Foundation

public enum Constants {
    struct Request {
        static let baseURL = "https://api.weatherapi.com/v1/"
    }
    
    struct UserDefaults {
        static let saveFavoriteItems = "saveFavoriteItems"
        static let localFavoriteItems = "localFavoriteItems"
    }
    
    static let openWeatherWebURL = "https://weather.com/"
    
    struct Text {
        static let forecastAdded = "Forecast added to favorites"
        static let forecastRemoved = "Forecast removed from favorites"
        static let loading = "Loading..."
        
        struct Error {
            static let addingForecast = "Error adding forecast to favorites"
        }
    }
}

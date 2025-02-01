import Foundation

class WeatherRepository: NetworkManager {
    
    func getSearch(model: WeatherInput,
                   completion: @escaping(_ result: [SearchResponse]) -> Void,
                   errorMessage: @escaping (String) -> Void) {
        let api = ApiRouter.search(model)
        request(api, success: completion, errorMessage: errorMessage)
    }
    
    func getForecast(model: WeatherInput,
                     completion: @escaping(_ result: ForecastResponse) -> Void,
                     errorMessage: @escaping (String) -> Void) {
        let api = ApiRouter.forecast(model)
        request(api, success: completion, errorMessage: errorMessage)
    }
}

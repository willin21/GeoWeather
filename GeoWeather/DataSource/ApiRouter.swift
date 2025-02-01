import Alamofire

enum ApiRouter: URLRequestConvertible {
    case search(_ model: WeatherInput)
    case forecast(_ model: WeatherInput)
    
    var absoluteUrl: String {
        switch self {
        default:
            return getBaseDomain()
        }
    }
    
    func getBaseDomain() -> String {
        switch self {
        default:
            return Constants.Request.baseURL + path
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "search.json"
        case .forecast:
            return "forecast.json"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .search, .forecast:
            return [:]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .forecast:
            return .post
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .search(let params):
            
            return ["key": params.key,
                    "q": params.query]
        case .forecast(let params):
            
            return ["key": params.key,
                    "q": params.query,
                    "days": params.days ?? 0]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .search, .forecast:
            return URLEncoding.httpBody
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try absoluteUrl.asURL()
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        urlRequest = try encoding.encode(urlRequest, with: params)
        
        return urlRequest
    }
}


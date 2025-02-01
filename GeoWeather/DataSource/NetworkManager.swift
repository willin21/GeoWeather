import UIKit
import Alamofire

class NetworkManager {
    
    func request<T: Decodable>(
        _ urlRequest: URLRequestConvertible,
        success: @escaping (_ result: T) -> Void,
        errorMessage: @escaping (String) -> Void
    ) {
        AF.request(urlRequest)
            .validate()
            .response { (response) -> Void in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(T.self, from: data)
                            success(model)
                        } catch let error as NSError {
                            errorMessage("Failed to decode: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    let message: String
                    if let httpStatusCode = response.response?.statusCode {
                        message = "Error: \(httpStatusCode)"
                    } else {
                        message = error.localizedDescription
                    }
                    errorMessage(message)
                }
            }
    }
}

import Foundation

typealias SearchList = [SearchResponse]

struct SearchResponse: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}

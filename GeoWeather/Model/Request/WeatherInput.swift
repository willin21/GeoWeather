struct WeatherInput {
    let key: String
    let query: String
    let days: Int?
    
    init(key:String, query: String, days: Int? = nil) {
        self.key = key
        self.query = query
        self.days = days
    }
}

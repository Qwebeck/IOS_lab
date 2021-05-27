import Foundation

struct WeatherModel {
    var records: Array<WeatherRecord> = []

    init(cities: Array<String>) {
        records = Array<WeatherRecord>()
    
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
    }

    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherState: String = "Clear"
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidity: Float = Float.random(in: 0.0 ... 30.0)
        var windSpeed: Float = Float.random(in: 0.0 ... 30.0)
        var windDirection: Float = Float.random(in: 0 ..< 360.0)
    }
    
    mutating func refresh(recordId: UUID, weatherDescription: ConsolidateWeatherDescription) {
        let idx = records.firstIndex { $0.id == recordId } ?? 0
        records[idx].temperature = weatherDescription.the_temp
        records[idx].weatherState = weatherDescription.weather_state_name
        print("Refreshing record: \(records[idx])")
        
    }
}

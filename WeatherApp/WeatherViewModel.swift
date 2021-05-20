import Foundation
import Combine


struct WeatherResponse: Decodable {
    let title: String
    let consolidate_weather: ConsolidateWeatherDescription
}
struct ConsolidateWeatherDescription: Decodable {
    let weather_state_name: String
}

class WeatherViewModel: ObservableObject {

    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw", "Cracow", "Wroclaw", "London", "Kyiv", "Dnipro", "Sydney","Lviv", "Lodz", "Manchester"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }

    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
        let url: URL =  URL(string: "https://www.metaweather.com/api/location/44418/")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .sink (receiveCompletion: { weather in
                
            },
                   receiveValue: { weather in
                    let newRecord = WeatherModel.WeatherRecord(cityName: record.cityName, weatherState: weather.consolidate_weather.weather_state_name)
                    self.model.refresh(record: newRecord)
            })
        
    }
}

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}

struct WeatherResponse: Decodable {
    let title: String
    let consolidated_weather: Array<ConsolidateWeatherDescription>
}
struct ConsolidateWeatherDescription: Decodable {
    let weather_state_name: String
    let the_temp: Float
}

class WeatherViewModel: ObservableObject {
    var cancellable: Cancellable?;

    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw", "Cracow", "Wroclaw", "London", "Kyiv", "Dnipro", "Sydney","Lviv", "Lodz", "Manchester"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }

    func refresh(record: WeatherModel.WeatherRecord) {
        let url: URL =  URL(string: "https://www.metaweather.com/api/location/44418/")!
        let request = URLRequest(url: url)
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw HTTPError.statusCode
                    }
                return output.data
                
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { error in
                print(error)
            }) { weather in
                self.model.refresh(recordId: record.id, weatherDescription: weather.consolidated_weather[0])
            }
    }
}

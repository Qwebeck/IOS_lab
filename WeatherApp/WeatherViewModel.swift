import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}

struct ConsolidateWeatherDescription: Decodable {
    let weather_state_name: String
    let the_temp: Float
}

class WeatherViewModel: ObservableObject {
    var cancellable: Cancellable?;
    
    static var citites: [String: Int] = [
        "London": 44418,
        "San-Francisco": 2487956
    ]
    @Published private(set) var model: WeatherModel = WeatherModel(cities: Array(citites.keys)
                                                                    )
    
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }

    func refresh(record: WeatherModel.WeatherRecord) {
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())

        let url: URL =  URL(string: "https://www.metaweather.com/api/location/\(WeatherViewModel.citites[record.cityName]!)/\(today.year!)/\(today.month!)/\(today.day!)/")!
        let request = URLRequest(url: url)
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw HTTPError.statusCode
                    }
                return output.data
                
            }
            .decode(type: Array<ConsolidateWeatherDescription>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { error in
                print(error)
            }) { weather in
                self.model.refresh(recordId: record.id, weatherDescription: weather[0])
            }
    }
}

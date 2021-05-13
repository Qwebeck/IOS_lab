import Foundation 

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw", "Kraków", "Paris", "London", "Dublin", "Berlin", "Madrid"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }

    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }

}

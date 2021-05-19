import Foundation 

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw", "Cracow", "Wroclaw", "London", "Kyiv", "Dnipro", "Sydney","Lviv", "Lodz", "Manchester"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }

    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }

}

//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Użytkownik Gość on 10/06/2021.
//

import Foundation

import SwiftUI

struct WeatherDetail: View {
    var weatherRecord : WeatherModel.WeatherRecord
    var body: some View {
        VStack {
            Text(weatherRecord.cityName)
            Divider()
            Text("Weather state: \(weatherRecord.weatherState)")
            Text(String(format: "Temperature: %.2f", weatherRecord.temperature))
            Text(String(format: "Humidity: %.2f", weatherRecord.humidity))
            Text(String(format: "Wind speec: %.2f", weatherRecord.windSpeed))
        }
        
    }
}

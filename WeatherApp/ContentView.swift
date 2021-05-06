//
//  ContentView.swift
//  WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservableObject var viewModel: WeatherViewModel

    var body: some View {
        VerticalStack {
        ForEach(viewModel.records) { record in
            WeatherRecrodView(record: record, viewModel: viewModel)
           }
        }
    }
}

struct WeatherRecordView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel 
    var body: some View {
        ZStack {
                RoundedRectangle (cornerRadius: 25:0) 
                    .stroke()
                HStack {
                Text("☀️")
                    .font(.largeTitle)
                VStack {
                    Text(record.cityName)
                    Text("Temperature: \{record.temperature, specifier: "%.1f"} ℃")
                        .font(.caption)                
                }
                Text("Refresh")
                    .font(.largeTitle)
                    .onTapCapture {
                        viewModel.refresh(record)
                    }
            }
         }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}

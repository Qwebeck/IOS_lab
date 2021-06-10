//
//  ContentView.swift
//  WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let ITEM_SPACING: CGFloat = 10

    var body: some View {
        NavigationView {
          ScrollView(.vertical) {
            VStack(spacing: ITEM_SPACING) {
            ForEach(viewModel.records) { record in
                NavigationLink (
                    destination: WeatherDetail(weatherRecord: record).navigationTitle("\(record.cityName) details")
                ) {
                    WeatherRecordView(record: record, viewModel: viewModel)
                    
                }
               }
            }
          }.navigationTitle("Weather")
        }
    }
}

struct WeatherRecordView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    let CONTAINER_CORNER_RADIUS: CGFloat = 25.0
    let HSTACK_SPACING: CGFloat = 40
    let CONTAINER_HEIGHT: CGFloat = 50
    var body: some View {
        ZStack {
            RoundedRectangle (
                cornerRadius: CONTAINER_CORNER_RADIUS
            )
            .stroke()
            
            HStack(spacing: HSTACK_SPACING) {
                Text("☀️")
                    .font(.largeTitle)
                   
                VStack(alignment: .leading) {
                    Text(record.cityName)
                    Text("Temperature: \(record.temperature, specifier: "%.1f") ℃")
                        .font(.caption)                
                }
                Text("🔄")
                    .font(.largeTitle)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
                
            
            }
        }.frame(height:CONTAINER_HEIGHT)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}

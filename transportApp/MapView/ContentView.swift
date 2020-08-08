//
//  ContentView.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
    @State private var locations = CustomPointAnnotation.sampleData
    @State private var selectedPlace: CustomPointAnnotation?
    @State private var showingSelectedPlace = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        MapView(annotaions: locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingSelectedPlace)
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showingSelectedPlace) {
                if self.selectedPlace != nil {
                    BusDetailsView(annotation: self.selectedPlace!)
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert"), message: Text(""), dismissButton: .default(Text("OK")))
            })
            .onAppear(perform: fetchBusesFromAPI)
        
    }
    
    func fetchBusesFromAPI() {
        
        return
        let urlString = ""
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    if let result = try? JSONDecoder().decode([Bus].self, from: data) {
                        self.locations = result.map { (bus) -> CustomPointAnnotation in
                            CustomPointAnnotation(progress: bus.getOccupancyRate(), isIncidentOccured: bus.isIncidentOccured, bus: bus)
                        }
                        return
                    } else {
                        self.errorMessage = "Unable to decode the json"
                        self.showAlert = true
                    }
                } else {
                    self.errorMessage = "Unable to get response from the server"
                    self.showAlert = true
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

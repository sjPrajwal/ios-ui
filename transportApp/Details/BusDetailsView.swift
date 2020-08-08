//
//  BusDetailsView.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import MapKit
struct BusDetailsView: View {
    var annotation: CustomPointAnnotation
   
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("")) {
                    Text("Occupancy \(annotation.bus.Occupied) out of \(annotation.bus.Capacity)")
                    Text("Average Time: 1 hr")
                }
                
                Section(header: Text("Fuel Level")) {
                    Text("Current Fuel Level is \(annotation.bus.fuel ?? "")")
                }
                
//                Section(header: "Service Interrupted") {
//                    Text("Bus service is currently interrupted")
//                }
                
            }
            .navigationBarTitle("Bus Details")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct BusDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BusDetailsView(annotation: CustomPointAnnotation.example)
    }
}

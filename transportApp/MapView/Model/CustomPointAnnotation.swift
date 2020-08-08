//
//  CustomPointAnnotation.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var progress: Float
    var isIncidentOccured: Bool
    var bus: Bus
    
    init(progress: Float, isIncidentOccured: Bool, bus: Bus) {
        self.progress = progress
        self.isIncidentOccured = isIncidentOccured
        self.bus = bus
    }
}

extension CustomPointAnnotation {
    static var example: CustomPointAnnotation {
        let bus = Bus()
        let annotation = CustomPointAnnotation(progress: bus.getOccupancyRate(), isIncidentOccured: bus.isIncidentOccured, bus: bus)
        annotation.title = bus.BusName
        annotation.subtitle = "Occupancy: \(bus.Occupied )/\(bus.Capacity)"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
        return annotation
    }
    
    static var sampleData: [CustomPointAnnotation] {
        var bus = Bus()
        var annotations = [CustomPointAnnotation]()
        let coordinates = [CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
                           CLLocationCoordinate2D(latitude: 12.9352, longitude: 77.6245),
                           CLLocationCoordinate2D(latitude: 12.9698, longitude: 77.7500),
                           CLLocationCoordinate2D(latitude: 12.9784, longitude: 77.6408)]
        
        for (index,coordinate) in coordinates.enumerated() {
            bus.BusName = index == 0 ? "Bangalore" : (index == 1 ? "Koramangala" : (index == 2 ? "Whitefield" : "IndiraNagar"))
            bus.Capacity = "50"
            bus.Occupied = index == 0 ? "25" : (index == 1 ? "35" : (index == 2 ? "45" : "20"))
            bus.fuel = index == 0 ? "80" : (index == 1 ? "70" : (index == 2 ? "60" : "50"))
            if index == 3 {
                bus.isIncidentOccured = true
            }

            let annotation = CustomPointAnnotation(progress: bus.getOccupancyRate(), isIncidentOccured: bus.isIncidentOccured, bus: bus)
            annotation.title = bus.BusName 
            annotation.subtitle = "Occupancy: \(bus.Occupied)/\(bus.Capacity)"
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        return annotations
    }
}

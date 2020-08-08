//
//  MapView.swift
//  transportApp
//
//  Created by Mac HD on 08/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var annotaions: [CustomPointAnnotation]
    
    @Binding var selectedPlace: CustomPointAnnotation?
    
    @Binding var showingPlaceDetails: Bool
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customAnnotation = annotation as? CustomPointAnnotation else { return nil }

            let customAnnotationView = self.customAnnotationView(in: mapView, for: customAnnotation)
            customAnnotationView.progress = customAnnotation.progress
            customAnnotationView.isIncidentOccured = customAnnotation.isIncidentOccured
            return customAnnotationView
        }
        
        private func customAnnotationView(in mapView: MKMapView, for annotation: CustomPointAnnotation) -> CustomAnnotationView {
            let identifier = "CustomAnnotationViewID"

            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let customAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                customAnnotationView.canShowCallout = true
                return customAnnotationView
            }
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let selectedPlace = view.annotation as? CustomPointAnnotation else {return}
            parent.selectedPlace = selectedPlace
            parent.showingPlaceDetails = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if annotaions.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotaions)
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotaions: [CustomPointAnnotation.example], selectedPlace: .constant(CustomPointAnnotation.example), showingPlaceDetails: .constant(false))
    }
}

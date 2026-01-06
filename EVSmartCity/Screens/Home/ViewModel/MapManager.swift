//
//  MapManager.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import MapKit

class MapManager: NSObject, ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var annotations: [EVStationAnnotation] = [] {
        didSet {
            updateVisibleAnnotations()
        }
    }
    
    func centerOnLocation(latitude: Double, longitude: Double) {
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func centerOnDefaultLocation() {
        centerOnLocation(latitude: 12.9716, longitude: 77.5946)
    }
    
    func zoomToFitAnnotations(_ annotations: [EVStationAnnotation]) {
        guard !annotations.isEmpty else { return }
        
        var minLat = annotations[0].coordinate.latitude
        var maxLat = annotations[0].coordinate.latitude
        var minLon = annotations[0].coordinate.longitude
        var maxLon = annotations[0].coordinate.longitude
        
        for annotation in annotations {
            minLat = min(minLat, annotation.coordinate.latitude)
            maxLat = max(maxLat, annotation.coordinate.latitude)
            minLon = min(minLon, annotation.coordinate.longitude)
            maxLon = max(maxLon, annotation.coordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.3,
            longitudeDelta: (maxLon - minLon) * 1.3
        )
        
        region = MKCoordinateRegion(center: center, span: span)
    }
    
    private func updateVisibleAnnotations() {
        // You can add logic here to filter annotations based on current region
        // For example, only show annotations in the current visible region
    }
}

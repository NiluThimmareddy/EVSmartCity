//
//  MapManager.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import MapKit

class MapManager {
    private(set) var currentRegion: MKCoordinateRegion
    private let defaultCenter = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
    private let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    
    let minZoomLevel: Double = 0.002
    let maxZoomLevel: Double = 50.0
    let zoomFactor: Double = 2.0
    
    init() {
        self.currentRegion = MKCoordinateRegion(center: defaultCenter, span: defaultSpan)
    }
    
    func updateRegion(_ region: MKCoordinateRegion) {
        currentRegion = region
    }
    
    func zoom(to coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan? = nil) {
        let newSpan = span ?? MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        currentRegion = MKCoordinateRegion(center: coordinate, span: newSpan)
    }
    
    func zoomToFitAnnotations(_ annotations: [EVStationAnnotationViewModel]) {
        guard !annotations.isEmpty else { return }
        
        let coordinates = annotations.map { $0.coordinate }
        
        var minLat = coordinates[0].latitude
        var maxLat = coordinates[0].latitude
        var minLon = coordinates[0].longitude
        var maxLon = coordinates[0].longitude
        
        for coordinate in coordinates {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.3,
            longitudeDelta: (maxLon - minLon) * 1.3
        )
        
        currentRegion = MKCoordinateRegion(center: center, span: span)
    }
    
    func calculateZoomedRegion(zoomIn: Bool, from currentRegion: MKCoordinateRegion) -> MKCoordinateRegion {
        let newLatitudeDelta = zoomIn ?
            currentRegion.span.latitudeDelta / zoomFactor :
            currentRegion.span.latitudeDelta * zoomFactor
        
        let newLongitudeDelta = zoomIn ?
            currentRegion.span.longitudeDelta / zoomFactor :
            currentRegion.span.longitudeDelta * zoomFactor
        
        let clampedLatDelta = max(minZoomLevel, min(maxZoomLevel, newLatitudeDelta))
        let clampedLonDelta = max(minZoomLevel, min(maxZoomLevel, newLongitudeDelta))
        
        return MKCoordinateRegion(
            center: currentRegion.center,
            span: MKCoordinateSpan(latitudeDelta: clampedLatDelta, longitudeDelta: clampedLonDelta)
        )
    }
}

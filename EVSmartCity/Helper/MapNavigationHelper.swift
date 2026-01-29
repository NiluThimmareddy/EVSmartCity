//
//  MapNavigationHelper.swift
//  EVSmartCity
//
//  Created by Toqsoft on 28/01/26.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

enum MapAppType {
    case inApp
    case appleMaps
    case googleMaps
    case waze
}

final class MapNavigationHelper {
    
    // MARK: - Availability checks
    
    static func isGoogleMapsInstalled() -> Bool {
        guard let url = URL(string: "comgooglemaps://") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    static func isWazeInstalled() -> Bool {
        guard let url = URL(string: "waze://") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    // MARK: - Open Navigation
    
    static func open(
        mapApp: MapAppType,
        from start: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        inAppHandler: (() -> Void)? = nil
    ) {
        switch mapApp {
        case .inApp:
            inAppHandler?()
            
        case .appleMaps:
            openAppleMaps(from: start, to: destination)
            
        case .googleMaps:
            openGoogleMaps(from: start, to: destination)
            
        case .waze:
            openWaze(to: destination)
        }
    }
    
    // MARK: - Apple Maps
    
    private static func openAppleMaps(
        from start: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D
    ) {
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: start))
        sourceItem.name = "My Location"
        
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        destinationItem.name = "Destination"
        
        MKMapItem.openMaps(
            with: [sourceItem, destinationItem],
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                MKLaunchOptionsShowsTrafficKey: true
            ]
        )
    }
    
    // MARK: - Google Maps
    
    private static func openGoogleMaps(
        from start: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D
    ) {
        let urlString =
        "comgooglemaps://?saddr=\(start.latitude),\(start.longitude)" +
        "&daddr=\(destination.latitude),\(destination.longitude)" +
        "&directionsmode=driving"
        
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Waze
    
    private static func openWaze(to destination: CLLocationCoordinate2D) {
        let urlString =
        "waze://?ll=\(destination.latitude),\(destination.longitude)&navigate=yes"
        
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

//
//  EVStationAnnotation.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//
import MapKit

struct EVStationAnnotationViewModel {
    let stationId: String
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
    let availablePorts: Int
    let status: String
    let chargerTypes: [String]
    
    init(from station: EVStation) {
        self.stationId = station.stationId
        self.coordinate = CLLocationCoordinate2D(
            latitude: station.latitude,
            longitude: station.longitude
        )
        self.title = station.name
        self.subtitle = "₹\(station.pricingPerKwh)/kWh • \(station.availablePorts) ports"
        self.availablePorts = station.availablePorts
        self.status = station.status
        self.chargerTypes = station.chargerTypes
    }
    
    var annotationColor: UIColor {
        switch status {
        case "Available": return .systemGreen
        case "Busy": return .systemOrange
        default: return .systemRed
        }
    }
    
    var chargerSymbol: String {
        if chargerTypes.contains("DC") && chargerTypes.contains("AC") {
            return "bolt.horizontal.circle.fill"
        } else if chargerTypes.contains("DC") {
            return "bolt.fill"
        } else {
            return "bolt.horizontal.fill"
        }
    }
}

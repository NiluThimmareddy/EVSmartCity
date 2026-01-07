//
//  EVStationAnnotation.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//
import MapKit

class EVStationAnnotation: NSObject, MKAnnotation {
    let station: EVStation
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(station: EVStation) {
        self.station = station
        self.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
        self.title = station.name
        self.subtitle = "₹\(station.pricingPerKwh)/kWh • \(station.availablePorts) ports"
        super.init()
    }
}

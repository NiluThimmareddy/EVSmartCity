//
//  LocationService.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import CoreLocation

final class LocationService : NSObject{
    private let locationManager = CLLocationManager()
    private var completion: ((String)-> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func fetchCurrentLocationName(completion: @escaping (String) -> Void) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let firstPlacemark = placemarks?.first else { return }
            
            let locationName = "\(firstPlacemark.locality ?? ""), \(firstPlacemark.name ?? "")"
            self?.completion?(locationName)
        }
        
        locationManager.stopUpdatingLocation()
    }
}

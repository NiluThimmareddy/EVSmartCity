//
//  LocationSearchViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 06/01/26.
//

import Foundation
import MapKit

class LocationSearchViewModel {
    
    func fetchCoordinates(from completion: MKLocalSearchCompletion, completionHandler: @escaping (CLLocationCoordinate2D?) -> Void){
        
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard error == nil else {
                completionHandler(nil)
                return
            }
            
            let coordinate = response?.mapItems.first?.placemark.coordinate ?? nil            
            completionHandler(coordinate)
        }
        
    }
}

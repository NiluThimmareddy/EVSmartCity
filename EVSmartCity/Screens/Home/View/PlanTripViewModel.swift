//
//  PlanTripViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import MapKit

final class PlanTripViewModel {
    
    private let locationService =  LocationService()
    private let searchService = SearchService()
    private let completer = MKLocalSearchCompleter()
    
    var onSuggestionsUpdate: (([LocationSuggestion]) -> Void)?
    var onCurrentLocationUpdate: ((String)-> Void)?
    
    private(set) var suggestions: [LocationSuggestion] = []
    
    init() {
        searchService.onResultsUpdate = { [weak self] results in
            self?.suggestions = results
            self?.onSuggestionsUpdate?(results)
        }
    }
    
    func fetchCurrentLocation() {
        locationService.fetchCurrentLocationName { [weak self] name in
            self?.onCurrentLocationUpdate?(name)
        }
    }
    
    func searchLocation(text: String) {
        guard !text.isEmpty else {
            return
        }
        searchService.search(query: text)
    }
    
    func suggestion(at index:Int) -> LocationSuggestion {
        return suggestions[index]
    }
}

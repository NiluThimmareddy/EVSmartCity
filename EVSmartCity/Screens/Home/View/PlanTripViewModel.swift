////
////  PlanTripViewModel.swift
////  EVSmartCity
////
////  Created by Toqsoft on 05/01/26.
////
//
//import MapKit
//
//final class PlanTripViewModel {
//    
//    var description: String
//    
//    
//    private let locationService =  LocationService()
//    private let searchService = SearchService()
//    
//    private let completer = MKLocalSearchCompleter()
//    private var mapResults: [MKLocalSearchCompletion] = []
//    
//    var onSuggestionsUpdate: (([LocationSuggestion]) -> Void)?
//    var onCurrentLocationUpdate: ((String)-> Void)?
//    
//    private(set) var suggestions: [LocationSuggestion] = []
//    
//    init() {
//        completer.delegate = self
//        completer.resultTypes = [.address, .physicalFeature]
//        searchService.onResultsUpdate = { [weak self] results in
//            self?.suggestions = results
//            self?.onSuggestionsUpdate?(results)
//        }
//    }
//    
//    
//    
//    func fetchCurrentLocation() {
//        locationService.fetchCurrentLocationName { [weak self] name in
//            self?.onCurrentLocationUpdate?(name)
//        }
//    }
//    
//    func searchLocation(text: String) {
//        guard !text.isEmpty else {
//            return
//        }
//        searchService.search(query: text)
//    }
//    
//    func suggestion(at index:Int) -> LocationSuggestion {
//        return suggestions[index]
//    }
//    
//    func mapCompletion(at index: Int) -> MKLocalSearchCompletion {
//            return mapResults[index]
//        }
//}
//
//
//extension PlanTripViewModel: MKLocalSearchCompleterDelegate {
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//
//        self.mapResults = completer.results
//
//        self.suggestions = completer.results.map {
//            LocationSuggestion(
//                title: $0.title,
//                subtitle: $0.subtitle
//            )
//        }
//
//        onSuggestionsUpdate?(suggestions)
//    }
//}


import MapKit

final class PlanTripViewModel: NSObject {

    private let locationService = LocationService()
    private let completer = MKLocalSearchCompleter()

    private var mapResults: [MKLocalSearchCompletion] = []

    private(set) var suggestions: [LocationSuggestion] = []

    var onSuggestionsUpdate: (([LocationSuggestion]) -> Void)?
    var onCurrentLocationUpdate: ((String) -> Void)?

    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
    }

    func fetchCurrentLocation() {
        locationService.fetchCurrentLocationName { [weak self] name in
            self?.onCurrentLocationUpdate?(name)
        }
    }

    func searchLocation(text: String) {
        completer.queryFragment = text
    }

    func suggestion(at index: Int) -> LocationSuggestion {
        suggestions[index]
    }

    func mapCompletion(at index: Int) -> MKLocalSearchCompletion {
        mapResults[index]
    }
}

extension PlanTripViewModel: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {

        mapResults = completer.results

        suggestions = completer.results.map {
            LocationSuggestion(
                title: $0.title,
                subtitle: $0.subtitle
            )
        }

        onSuggestionsUpdate?(suggestions)
    }
}




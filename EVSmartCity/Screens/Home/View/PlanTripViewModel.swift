//
//  PlanTripViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

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




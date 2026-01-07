//
//  SearchService.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import MapKit

final class SearchService : NSObject{
    private let comleter = MKLocalSearchCompleter()
    var onResultsUpdate: (([LocationSuggestion]) -> Void)?
    
    override init(){
        super.init()
        comleter.delegate = self
        comleter.resultTypes = [.address, .pointOfInterest]
    }
    
    func search(query: String){
        comleter.queryFragment = query
    }
}

extension SearchService : MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.map {
            LocationSuggestion(title: $0.title, subtitle: $0.subtitle)
        }
        
        onResultsUpdate?(results)
    }
}

//
//  RecenteSearchManager.swift
//  EVSmartCity
//
//  Created by Toqsoft on 06/01/26.
//

import Foundation
class RecenteSearchManager{
    static let shared = RecenteSearchManager()
    private let recentLocationKey = "recent_locations"
    
    private init() {}
    
    func save(_ location: RecentLocation){
        var locations = fetch()
        
        locations.removeAll(){
            $0.latitude == location.latitude &&
            $0.longitude == location.longitude &&
            $0.isSource == location.isSource
        }
        
        locations.insert(location, at: 0)
        
        locations = Array(locations.prefix(10))
        
        if let data = try? JSONEncoder().encode(locations){
            UserDefaults.standard.set(data, forKey: recentLocationKey)
        }
    }
    
    func fetch() -> [RecentLocation] {
        guard let data = UserDefaults.standard.data(forKey: recentLocationKey), let locations = try? JSONDecoder().decode([RecentLocation].self, from: data) else {
            return []
        }
        
        return locations
    }
    
    func clear(){
        UserDefaults.standard.removeObject(forKey: recentLocationKey)
    }
    
    fetchCoordinates(from: completion) { coordinate in
        guard let coordinate else { return }

        let recent = RecentLocation(
            title: completion.title,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            isSource: true, // false for destination
            date: Date()
        )

        RecentSearchManager.shared.save(recent)
    }
}

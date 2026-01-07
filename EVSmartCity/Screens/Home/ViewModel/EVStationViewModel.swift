//
//  EVStationViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation
import MapKit
import Combine

class EVStationViewModel: ObservableObject {
    @Published var evStations: [EVStation] = []
    @Published var selectedStation: EVStation?
    @Published var isLoading = false
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadEVStations()
    }
    
    func loadEVStations() {
        isLoading = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            if let path = Bundle.main.path(forResource: "StationList", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(EVStationResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.evStations = response.evStations
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.error = "Failed to load stations: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func selectStation(_ station: EVStation) {
        selectedStation = station
    }
    
    func deselectStation() {
        selectedStation = nil
    }
    
    func calculatePlugScore(for station: EVStation) -> Int? {
        var score = 0
        var hasValidData = false
        
        if station.availablePorts > 0 {
            if station.availablePorts >= 6 {
                score += 4
            } else if station.availablePorts >= 3 {
                score += 3
            } else if station.availablePorts >= 1 {
                score += 2
            }
            hasValidData = true
        }
        
        if !station.chargerTypes.isEmpty {
            if station.chargerTypes.contains("DC") {
                score += 3
            }
            if station.chargerTypes.contains("AC") {
                score += 1
            }
            hasValidData = true
        }
        
        if !station.status.isEmpty {
            if station.status == "Available" {
                score += 2
            } else if station.status == "Busy" {
                score += 1
            }
            hasValidData = true
        }
        return hasValidData ? min(score, 10) : nil
    }
    
    func getColorForStatus(_ status: String) -> UIColor {
        switch status {
        case "Available":
            return ColorManager.shared.systemGreen
        case "Busy":
            return ColorManager.shared.systemOrange
        default:
            return ColorManager.shared.systemRed
        }
    }
    
    func getStationAnnotations() -> [EVStationAnnotation] {
        return evStations.map { EVStationAnnotation(station: $0) }
    }
    
    // Renamed to avoid conflict - filter by city
    func filterStationsByCity(_ city: String) -> [EVStation] {
        guard !city.isEmpty else { return evStations }
        return evStations.filter { $0.city.lowercased().contains(city.lowercased()) }
    }
    
    // Renamed to avoid conflict - filter by charger type
    func filterStationsByChargerType(_ chargerType: String) -> [EVStation] {
        guard !chargerType.isEmpty else { return evStations }
        return evStations.filter { $0.chargerTypes.contains(chargerType) }
    }
    
    func getStationsSortedByDistance() -> [EVStation] {
        return evStations.sorted { $0.distanceKm < $1.distanceKm }
    }
    
    func getStationsSortedByPrice() -> [EVStation] {
        return evStations.sorted { $0.pricingPerKwh < $1.pricingPerKwh }
    }
    
    // Additional helper methods
    func filterByStatus(_ status: String) -> [EVStation] {
        guard !status.isEmpty else { return evStations }
        return evStations.filter { $0.status == status }
    }
    
    func filterByOperator(_ operatorName: String) -> [EVStation] {
        guard !operatorName.isEmpty else { return evStations }
        return evStations.filter { $0.operatorName.lowercased().contains(operatorName.lowercased()) }
    }
    
    func getAvailableStations() -> [EVStation] {
        return evStations.filter { $0.status == "Available" }
    }
}

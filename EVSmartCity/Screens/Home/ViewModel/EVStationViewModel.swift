//
//  EVStationViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation
import Combine
import MapKit

protocol EVStationListViewModelProtocol: ObservableObject {
    var annotations: [EVStationAnnotationViewModel] { get }
    var selectedStation: StationDetailsViewModel? { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var filterType: StationFilterType { get set }
    
    func loadStations()
    func selectStation(withId stationId: String)
    func deselectStation()
    func applyFilter(_ filter: StationFilterType)
}

enum StationFilterType {
    case all
    case available
    case dcFast
    case ac
    case sortedByDistance
    case sortedByPrice
    case city(String)
    case operatorName(String)
}

class EVStationListViewModel: EVStationListViewModelProtocol {
    @Published var annotations: [EVStationAnnotationViewModel] = []
    @Published var selectedStation: StationDetailsViewModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filterType: StationFilterType = .all
    
    private var allStations: [EVStation] = []
    private var filteredStations: [EVStation] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let dataService: EVStationDataServiceProtocol
    
    // Dependency Injection
    init(dataService: EVStationDataServiceProtocol = EVStationDataService()) {
        self.dataService = dataService
    }
    
    func loadStations() {
        isLoading = true
        errorMessage = nil
        
        dataService.fetchStations()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] stations in
                self?.allStations = stations
                self?.applyFilter(self?.filterType ?? .all)
            }
            .store(in: &cancellables)
    }
    
    func selectStation(withId stationId: String) {
        guard let station = allStations.first(where: { $0.stationId == stationId }) else { return }
        selectedStation = StationDetailsViewModel(station: station)
    }
    
    func deselectStation() {
        selectedStation = nil
    }
    
    func applyFilter(_ filter: StationFilterType) {
        filterType = filter
        filteredStations = filterStations(allStations, with: filter)
        annotations = filteredStations.map { EVStationAnnotationViewModel(from: $0) }
    }
    
    // MARK: - Private Methods
    private func filterStations(_ stations: [EVStation], with filter: StationFilterType) -> [EVStation] {
        switch filter {
        case .all:
            return stations
        case .available:
            return stations.filter { $0.status == "Available" }
        case .dcFast:
            return stations.filter { $0.chargerTypes.contains("DC") }
        case .ac:
            return stations.filter { $0.chargerTypes.contains("AC") }
        case .sortedByDistance:
            return stations.sorted { $0.distanceKm < $1.distanceKm }
        case .sortedByPrice:
            return stations.sorted { $0.pricingPerKwh < $1.pricingPerKwh }
        case .city(let city):
            guard !city.isEmpty else { return stations }
            return stations.filter { $0.city.lowercased().contains(city.lowercased()) }
        case .operatorName(let operatorName):
            guard !operatorName.isEmpty else { return stations }
            return stations.filter { $0.operatorName.lowercased().contains(operatorName.lowercased()) }
        }
    }
    func searchStations(with query: String) -> [EVStationAnnotationViewModel] {
        if query.isEmpty {
            return annotations
        }
        
        let lowercasedQuery = query.lowercased()
        
        return filteredStations.filter { station in
            // Search in station name
            if station.name.lowercased().contains(lowercasedQuery) {
                return true
            }
            
            // Search in address
            if station.address.lowercased().contains(lowercasedQuery) {
                return true
            }
            
            // Search in city
            if station.city.lowercased().contains(lowercasedQuery) {
                return true
            }
            
            // Search in operator name
            if station.operatorName.lowercased().contains(lowercasedQuery) {
                return true
            }
            
            // Search in connector types
            for connector in station.connectors {
                if connector.type.lowercased().contains(lowercasedQuery) {
                    return true
                }
            }
            
            return false
        }.map { EVStationAnnotationViewModel(from: $0) }
    }
}

//
//  StationDetailsViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

// StationDetailsViewModel.swift
import Foundation
import UIKit

class StationDetailsViewModel: ObservableObject {
    @Published var station: EVStation
    
    init(station: EVStation) {
        self.station = station
    }
    
    var stationName: String {
        station.name
    }
    
    var distanceText: String {
        String(format: "%.1f km away", station.distanceKm)
    }
    
    var address: String {
        station.address
    }
    
    var cityState: String {
        "\(station.city), \(station.state)"
    }
    
    var pricingText: String {
        "₹\(station.pricingPerKwh)/kWh"
    }
    
    var operatorText: String {
        "Operator: \(station.operatorName)"
    }
    
    var availablePortsText: String {
        "\(station.availablePorts) ports available"
    }
    
    var statusText: String {
        "Status: \(station.status)"
    }
    
    var statusColor: UIColor {
        station.status == "Available" ? .systemGreen : .systemOrange
    }
    
    var lastUpdatedText: String {
        formatDate(station.lastUpdated)
    }
    
    var chargerTypesText: String {
        station.chargerTypes.joined(separator: ", ")
    }
    
    var connectors: [ConnectorCellViewModel] {
        station.connectors.map { ConnectorCellViewModel(connector: $0) }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, h:mm a"
            return "Updated: \(displayFormatter.string(from: date))"
        }
        
        return "Updated: Recently"
    }
}

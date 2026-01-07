//
//  StationDetailsViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation
import UIKit

struct StationDetailsViewModel {
    private let station: EVStation
    
    init(station: EVStation) {
        self.station = station
    }
    
    // MARK: - Computed Properties
    var stationName: String { station.name }
    var stationId: String { station.stationId }
    var address: String { station.address }
    var cityState: String { "\(station.city), \(station.state)" }
    
    var distanceText: String {
        String(format: "%.1f km away", station.distanceKm)
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
    
    var statusText: String { station.status }
    
    var statusColor: UIColor {
        switch station.status {
        case "Available": return .systemGreen
        case "Busy": return .systemOrange
        default: return .systemRed
        }
    }
    
    var lastUpdatedText: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: station.lastUpdated) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, h:mm a"
            return "Updated: \(displayFormatter.string(from: date))"
        }
        return "Updated: Recently"
    }
    
    var chargerTypesText: String {
        station.chargerTypes.joined(separator: ", ")
    }
    
    var connectors: [ConnectorCellViewModel] {
        station.connectors.map { ConnectorCellViewModel(from: $0) }
    }
    
    var plugScore: Int? {
        calculatePlugScore()
    }
    
    var plugScoreText: String? {
        guard let score = plugScore else { return nil }
        return "Plug Score: \(score)/10"
    }
    
    var plugScoreColor: UIColor {
        guard let score = plugScore else { return .clear }
        return score >= 7 ? .systemGreen : (score >= 4 ? .systemOrange : .systemRed)
    }
    
    // MARK: - Private Methods
    private func calculatePlugScore() -> Int? {
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
}

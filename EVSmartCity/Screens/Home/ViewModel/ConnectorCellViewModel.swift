//
//  ConnectorCellViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import UIKit

struct ConnectorCellViewModel {
    let type: String
    let plugsCount: Int
    let powerKw: Int
    let status: String
    
    init(from connector: Connector) {
        self.type = connector.type
        self.plugsCount = connector.plugs
        self.powerKw = connector.powerKw
        self.status = connector.status
    }
    
    var statusColor: UIColor {
        switch status {
        case "Available": return .systemGreen
        case "Busy": return .systemOrange
        default: return .systemRed
        }
    }
    
    var displayText: String {
        "\(type) • \(plugsCount) plugs • \(powerKw) kW"
    }
    
    var detailedText: String {
        "\(type) (\(powerKw) kW)"
    }
}

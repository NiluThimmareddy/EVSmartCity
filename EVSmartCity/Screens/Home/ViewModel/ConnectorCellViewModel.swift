//
//  ConnectorCellViewModel.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation
import UIKit

struct ConnectorCellViewModel {
    let connector: Connector
    
    var type: String {
        return connector.type
    }
    
    var plugsCount: Int {
        return connector.plugs
    }
    
    var statusColor: UIColor {
        switch connector.status {
        case "Available":
            return .systemGreen
        case "Busy":
            return .systemOrange
        default:
            return .systemRed
        }
    }
}

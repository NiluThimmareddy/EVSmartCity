//
//  VehicleBrandModel.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import Foundation
import UIKit

struct VehicleBrandModel: Codable {
    var brandImage : String
    var brandname : String
    var brandDescription : String
}

struct VehicleModel: Codable {
    var modelImage : String
    var modelName : String
    var connectorType : String
}

struct ConnectorTypes : Codable {
    var connectorTypeImg : String
    var connectorName : String
    var chargingType : String
}

struct VehicleColour {
    let colour: UIColor
}

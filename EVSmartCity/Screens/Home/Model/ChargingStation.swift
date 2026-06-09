//
//  ChargingStation.swift
//  EVSmartCity
//
//  Created by Hitman on 08/06/26.
//

import Foundation

struct ChargingStation: Codable {
    let stationName: String
    let operatorName: String
    let distanceKm: Double
    let distanceMin: Int
    let reliabilityScore: Int
    let availability: Availability
    let connectorTypes: [ConnectorsTypes]
    let powerKw: Int?
    let powerType: PowerType?
    let waitTime: String?
    let rating: Double
    let reviewCount: Int
    let isOffline: Bool
    let amenities: [Amenity]
}

struct Availability: Codable {
    let status: String 
    let freeSlots: Int?
    let totalSlots: Int?
}

enum ConnectorsTypes: String, Codable {
    case ccs2 = "CCS2"
    case type2 = "Type 2"
    case chademo = "CHAdeMO"
}

enum PowerType: String, Codable {
    case fast = "Fast"
    case ac = "AC"
}

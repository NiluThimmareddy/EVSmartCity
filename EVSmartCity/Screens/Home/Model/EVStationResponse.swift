//
//  EVStationResponse.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation

struct EVStationResponse: Codable {
    let evStations: [EVStation]

    enum CodingKeys: String, CodingKey {
        case evStations = "ev_stations"
    }
}

struct EVStation: Codable {
    let stationId: String
    let name: String
    let city: String
    let state: String
    let latitude: Double
    let longitude: Double
    let distanceKm: Double
    let chargerTypes: [String]
    let connectors: [Connector]
    let status: String
    let availablePorts: Int
    let pricingPerKwh: Int
    let operatorName: String
    let address: String
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case stationId = "station_id"
        case name
        case city
        case state
        case latitude
        case longitude
        case distanceKm = "distance_km"
        case chargerTypes = "charger_types"
        case connectors
        case status
        case availablePorts = "available_ports"
        case pricingPerKwh = "pricing_per_kwh"
        case operatorName = "operator"
        case address
        case lastUpdated = "last_updated"
    }
}

struct Connector: Codable {
    let type: String
    let plugs: Int
    let powerKw: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case type
        case plugs
        case powerKw = "power_kw"
        case status
    }
}

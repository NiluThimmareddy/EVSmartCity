//
//  ChargingStation.swift
//  EVSmartCity
//
//  Created by Hitman on 02/06/26.
//

import Foundation

struct FavouriteChargingStationModel {
    let stationName: String
    let stationAddress: String
    let distance: String
    let stationType: String
    let availability: String
}

struct FavouriteRouteModel {
    let title: String
    let currentAddress: String
    let destinationAddress: String
    let stops: String
    let time: String
    let distance: String
}

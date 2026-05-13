//
//  LoggedInDevice.swift
//  EVSmartCity
//
//  Created by Hitman on 12/05/26.
//

import Foundation

struct LoggedInDevice: Codable {
    let deviceName: String
    let os: String
    let location: String
    let lastActive: String
    let isCurrentDevice: Bool
    let deviceImage: String
}

struct LoggedInDevicesResponse: Codable {
    let totalCount: Int
    let devices: [LoggedInDevice]
}

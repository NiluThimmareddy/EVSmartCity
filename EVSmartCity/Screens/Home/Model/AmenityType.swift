//
//  AmenityType.swift
//  EVSmartCity
//
//  Created by Hitman on 08/06/26.
//

import Foundation

struct Amenity: Codable {
    let id: String
    let name: String
    let iconName: String  // SF Symbol or custom image name
    let isAvailable: Bool
}

enum AmenityType: String, CaseIterable {
    case restroom = "Restroom"
    case cafe = "Cafe"
    case restaurant = "Restaurant"
    case shop = "Shop"
    case parking = "Parking"
    case wifi = "WiFi"
    case waitingLounge = "Waiting Lounge"
    case prayerRoom = "Prayer Room"
    case carWash = "Car Wash"
    case tireRepair = "Tire Repair"
    case security = "24/7 Security"
    case lighting = "Good Lighting"
    case covered = "Covered Parking"
    
    var iconName: String {
        switch self {
        case .restroom: return "figure.restroom"
        case .cafe: return "cup.and.saucer.fill"
        case .restaurant: return "fork.knife"
        case .shop: return "bag.fill"
        case .parking: return "p.circle.fill"
        case .wifi: return "wifi"
        case .waitingLounge: return "sofa.fill"
        case .prayerRoom: return "mosque.fill"
        case .carWash: return "car.wash"
        case .tireRepair: return "wrench.and.screwdriver"
        case .security: return "video.fill"
        case .lighting: return "lightbulb.fill"
        case .covered: return "car.top.door.front.left.open"
        }
    }
}

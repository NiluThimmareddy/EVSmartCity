//
//  SettingsModel.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.
//

import Foundation

enum CellType {
    case biometric
    case changePasscode
    case deviceManagement
    case permissions
    case appVersion
    case termsConditions
    case privacyPolicy
    case rateApp
    case shareApp
}

struct SettingsItem {
    let type: CellType
    let title: String
    let description: String
    let iconName: String
    let hasSwitch: Bool
    let hasBadge: Bool
    let hasButton: Bool
    let badgeText: String?
}

enum SettingsSection: Int, CaseIterable {
    case securityPrivacy = 0
    case aboutApp = 1
}

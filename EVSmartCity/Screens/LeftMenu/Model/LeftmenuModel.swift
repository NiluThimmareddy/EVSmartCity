//
//  LeftmenuModel.swift
//  EVSmartCity
//
//  Created by Hitman on 18/05/26.

import Foundation

struct SideMenuModel {
    let image: String
    let title: String
    let description: String
    let isPreference: Bool?
    
    init(image: String, title: String, description: String, isPreference: Bool? = nil) {
        self.image = image
        self.title = title
        self.description = description
        self.isPreference = isPreference
    }
}

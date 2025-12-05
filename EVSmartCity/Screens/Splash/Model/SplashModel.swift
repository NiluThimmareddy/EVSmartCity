//
//  SplashModel.swift
//  EVSmartCity
//
//  Created by ToqSoft on 01/12/25.
//

import Foundation


struct SplashScreenData {
    let image: String
    let title: String
    let description: String
    let continueButtonTitle : String
    
    init(image: String, title: String, description: String, continueButtonTitle: String) {
        self.image = image
        self.title = title
        self.description = description
        self.continueButtonTitle = continueButtonTitle
    }
}

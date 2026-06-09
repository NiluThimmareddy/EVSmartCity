//
//  File.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import Foundation


struct LocationSuggestion
{
    let title : String
    let subtitle : String
    
}


struct RecentLocation: Codable {
    let title : String
    let latitude : Double
    let longitude : Double
    let isSource : Bool
    let date : Date
}

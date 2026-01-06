//
//  UIColor+Extensions.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

// ColorManager.swift
import UIKit

class ColorManager {
    static let shared = ColorManager()
    
    private init() {}
    
    var systemGreen: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGreen
        } else {
            return UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
        }
    }
    
    var systemOrange: UIColor {
        if #available(iOS 13.0, *) {
            return .systemOrange
        } else {
            return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
        }
    }
    
    var systemRed: UIColor {
        if #available(iOS 13.0, *) {
            return .systemRed
        } else {
            return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        }
    }
    
    var systemBlue: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBlue
        } else {
            return UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        }
    }
}

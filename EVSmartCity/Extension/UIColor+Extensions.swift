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

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

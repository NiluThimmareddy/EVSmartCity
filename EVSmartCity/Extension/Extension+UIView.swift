//
//  Extension+UIView.swift
//  SyriaBookingApp
//  Created by ToqSoft on 02/08/25.
import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func applyShadow(color: UIColor = .black,alpha: Float = 0.2,x: CGFloat = 0,y: CGFloat = 2,blur: CGFloat = 6,spread: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func applyOrangeGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(hex: "#FF9800").cgColor,
            UIColor(hex: "#F57C00").cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        
        if let sublayers = layer.sublayers {
            for layer in sublayers where layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        }
        gradientLayer.name = "gradient"
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

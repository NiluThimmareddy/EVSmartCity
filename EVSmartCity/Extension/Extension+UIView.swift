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
    
    func applyLightShadow(color: UIColor = .lightGray,alpha: Float = 0.5,x: CGFloat = 0,y: CGFloat = 1,blur: CGFloat = 4) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        layer.shadowPath = nil
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
    
    func applyGreenGradient() {
        layer.sublayers?.removeAll(where: { $0.name == "gradient" })
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradient"
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.colors = [
            UIColor(hex: "#1E6B58").cgColor,
            UIColor(hex: "#00A977").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addDashedBorder(color: UIColor = .lightGray,lineWidth: CGFloat = 1.5,dashPattern: [NSNumber] = [6, 4],
                         cornerRadius: CGFloat = 8) {
        layer.sublayers?.removeAll(where: { $0.name == "dashedBorder" })
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "dashedBorder"
        shapeLayer.frame = bounds
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = dashPattern
        
        shapeLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    func applyLightGreenGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        gradient.colors = [
            UIColor(hex: "#059669").cgColor,
            UIColor(hex: "#10B981").cgColor,
            UIColor(hex: "#34D399").cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGoldMemberGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds

        gradient.colors = [
            UIColor(hex: "#343A40").cgColor,
            UIColor(hex: "#6C757D").cgColor
        ]

        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)

        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 0)
    }
}

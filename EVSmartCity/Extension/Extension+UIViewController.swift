//
//  UIViewControllerExtension.swift
//  EVSmartCity
//
//  Created by ToqSoft on 05/12/25.
//

import Foundation
import UIKit
import MapKit


extension UIViewController {
    func openHomePage(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "CustomeTabBarViewController") as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
    
    func openSplashScreen(){
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController {
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
    
    func openLoginPage(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? UIViewController {
            tabBarVC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(tabBarVC, animated: true)
            self.present(tabBarVC, animated: true)
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardGlobally))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboardGlobally() {
        view.endEditing(true)
    }
}

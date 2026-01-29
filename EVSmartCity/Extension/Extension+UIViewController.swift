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
    

}

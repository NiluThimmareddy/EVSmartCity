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
    
    func biometricAuthPage() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "BiometricAuthVC") as! BiometricAuthVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
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

extension UIViewController {
    
    func showToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .center) {
        let toast = UILabel()
        toast.text = message
        toast.textAlignment = .center
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toast.textColor = .white
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.font = UIFont.systemFont(ofSize: 14)
        toast.numberOfLines = 0
        
        let maxWidth = view.frame.width - 40
        let textSize = (message as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)],
            context: nil
        )
        
        let toastWidth = min(textSize.width + 40, maxWidth)
        let toastHeight = max(textSize.height + 20, 40)
        
        var yPosition: CGFloat
        switch position {
        case .top:
            yPosition = view.safeAreaInsets.top + 20
        case .center:
            yPosition = (view.frame.height / 2) - (toastHeight / 2)
        case .bottom:
            yPosition = view.frame.height - toastHeight - 50
        }
        
        toast.frame = CGRect(
            x: (view.frame.width - toastWidth) / 2,
            y: yPosition,
            width: toastWidth,
            height: toastHeight
        )
        
        view.addSubview(toast)
        
        // Animate
        toast.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            toast.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toast.alpha = 0
            }) { _ in
                toast.removeFromSuperview()
            }
        }
    }
}

// MARK: - Toast Position Enum
enum ToastPosition {
    case top
    case center
    case bottom
}

extension UIViewController {
    
    func showAlert(
        title: String = "Notice",
        message: String,
        buttonTitle: String = "OK",
        buttonStyle: UIAlertAction.Style = .default,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: buttonStyle) { _ in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancel(
        title: String = "Notice",
        message: String,
        confirmTitle: String = "OK",
        cancelTitle: String = "Cancel",
        confirmHandler: (() -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextField(
        title: String = "Input",
        message: String? = nil,
        placeholder: String = "",
        confirmTitle: String = "OK",
        cancelTitle: String = "Cancel",
        confirmHandler: @escaping (String) -> Void,
        cancelHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            let text = alert.textFields?.first?.text ?? ""
            confirmHandler(text)
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

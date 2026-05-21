//
//  SignOutVC.swift
//  EVSmartCity
//
//  Created by Hitman on 18/05/26.

import UIKit

class SignOutVC: UIViewController {

    @IBOutlet weak var signOutLabel: UILabel!
    @IBOutlet weak var areYouSureLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        showAlert(title: "Logout",message: "Are you sure you want to logout?",buttonTitle: "Yes",buttonStyle: .destructive
        ) {
            self.logoutAndNavigateToLogin()
        }
    }
    
    private func logoutAndNavigateToLogin() {
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
}

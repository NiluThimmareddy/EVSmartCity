//
//  BiometricAuthVC.swift
//  EVSmartCity
//
//  Created by Hitman on 15/06/26.
//

import UIKit

class BiometricAuthVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var engLanguageButton: UIButton!
    @IBOutlet weak var arabicLanguageButton: UIButton!
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var signinSecurelyLabel: UILabel!
    @IBOutlet weak var readyToVerifyButton: UIButton!
    @IBOutlet weak var faceOrFingerprintButton: UIButton!
    @IBOutlet weak var useAnotherMethodButton: UIButton!
    @IBOutlet weak var secureBiometricProtectionButton: UIButton!
    @IBOutlet weak var faceIdView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceIdView.applyShadow()
    }
    
    @IBAction func engLanguageButtonAction(_ sender: Any) {
    }
    
    @IBAction func arabicLanguageButtonAction(_ sender: Any) {
        openHomePage()
    }
    
    @IBAction func faceOrFingerprintButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Biometric", bundle: nil).instantiateViewController(withIdentifier: "BiometricLoginVC") as! BiometricLoginVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func useAnotherMethodbuttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

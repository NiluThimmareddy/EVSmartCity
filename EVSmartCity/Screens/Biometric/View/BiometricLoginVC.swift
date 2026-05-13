//
//  BiometricLoginVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/05/26.
//

import UIKit

class BiometricLoginVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var biometricLoginTitleLabel: UILabel!
    @IBOutlet weak var touchAuthenticateLabel: UILabel!
    @IBOutlet weak var useFaceIDorFingerprintLabel: UILabel!
    @IBOutlet weak var useFaceIdButton: UIButton!
    @IBOutlet weak var useFingerprintButton: UIButton!
    @IBOutlet weak var usePasscodeButton: UIButton!
    @IBOutlet weak var yourBiometricDataNeverLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func useFaceIdButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "FaceIDVC") as! FaceIDVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
    
    @IBAction func useFingerPrintButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "FingerprintVerificationVC") as! FingerprintVerificationVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func usePasscodeButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "EnterYourPasscodeVC") as! EnterYourPasscodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    
}

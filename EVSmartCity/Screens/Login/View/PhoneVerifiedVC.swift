//
//  PhoneVerifiedVC.swift
//  EVSmartCity
//
//  Created by Hitman on 12/06/26.
//

import UIKit

class PhoneVerifiedVC: UIViewController {

    @IBOutlet weak var phoneVerifiedLabel: UILabel!
    @IBOutlet weak var yourAccounthasBeenSuccessfullyLabel: UILabel!
    @IBOutlet weak var numberVerifiedLabel: UILabel!
    @IBOutlet weak var verifiedNumberLabel: UILabel!
    @IBOutlet weak var accountActivatedLabel: UILabel!
    @IBOutlet weak var readytoUseEVFinderLabel: UILabel!
    @IBOutlet weak var goToHomeButton: UIButton!
    
    var source: VerificationSource = .login
    var verifiedMobileNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if source == .login {
            goToHomeButton.setTitle("Go to Home", for: .normal)
        } else {
            goToHomeButton.setTitle("Continue", for: .normal)
        }
        verifiedNumberLabel.text = verifiedMobileNumber
        readytoUseEVFinderLabel.clipsToBounds = true
    }
    
    @IBAction func goToHomeButtonAction(_ sender: Any) {
        if source == .login {
            openHomePage()
        } else {
            let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SetLocationVC") as! SetLocationVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

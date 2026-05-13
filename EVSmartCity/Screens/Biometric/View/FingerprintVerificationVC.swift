//
//  FingerprintVerificationVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/05/26.
//

import UIKit

class FingerprintVerificationVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fingerPrintVerificationLabel: UILabel!
    @IBOutlet weak var fingerprintView: UIView!
    @IBOutlet weak var placeYourFingerLabel: UILabel!
    @IBOutlet weak var placeYourFingerOnSensorLabel: UILabel!
    @IBOutlet weak var secureAndPrivateButton: UIButton!
    @IBOutlet weak var useFaceIDButton: UIButton!
    @IBOutlet weak var usePasscodeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func useFaceIDButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "FaceIDVC") as! FaceIDVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
    
    @IBAction func usePasscodeButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "EnterYourPasscodeVC") as! EnterYourPasscodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

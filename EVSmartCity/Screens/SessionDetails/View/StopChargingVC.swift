//
//  StopChargingVC.swift
//  EVSmartCity
//
//  Created by Hitman on 07/07/26.
//

import UIKit

class StopChargingVC: UIViewController {

    @IBOutlet weak var stopChargingImmediatelyLabel: UILabel!
    @IBOutlet weak var chargingSessionWillEndSafelyLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var stopChargingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.applyShadow()
    }
    
    @IBAction func cancelbuttonaction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func stopChargingButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "SessionStoppedVC") as! SessionStoppedVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}

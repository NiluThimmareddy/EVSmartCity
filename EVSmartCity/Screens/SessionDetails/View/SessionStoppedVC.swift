//
//  SessionStoppedVC.swift
//  EVSmartCity
//
//  Created by Hitman on 09/07/26.
//

import UIKit

class SessionStoppedVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ocppStatusButton: UIButton!
    @IBOutlet weak var sessionStoppedLabel: UILabel!
    @IBOutlet weak var chargingEndedSafelyLabel: UILabel!
    @IBOutlet weak var chargingStoppedView: UIView!
    @IBOutlet weak var sessionSummaryView: UIView!
    @IBOutlet weak var vehicleBatteryStatusView: UIView!
    @IBOutlet weak var whatToDoNextView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [chargingStoppedView,sessionSummaryView,vehicleBatteryStatusView,whatToDoNextView,bottomView].forEach { shadow in
            shadow?.applyLightShadow()
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}

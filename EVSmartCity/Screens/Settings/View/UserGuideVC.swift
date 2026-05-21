//
//  UserGuideVC.swift
//  EVSmartCity
//
//  Created by Hitman on 19/05/26.
//

import UIKit

class UserGuideVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideSrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userGuideLabel: UILabel!
    @IBOutlet weak var learnHowToUseLabel: UILabel!
    @IBOutlet weak var gettingStartedLabel: UILabel!
    @IBOutlet weak var learnTheBasicsLabel: UILabel!
    @IBOutlet weak var createYourAccountLabel: UILabel!
    @IBOutlet weak var signUpUsingYourMoblieNumberLabel: UILabel!
    @IBOutlet weak var addYourVehicleLabel: UILabel!
    @IBOutlet weak var addYourEVDetailsLabel: UILabel!
    @IBOutlet weak var findNearByChargersLabel: UILabel!
    @IBOutlet weak var useTheMapLabel: UILabel!
    @IBOutlet weak var startChargingLabel: UILabel!
    @IBOutlet weak var scanTheStationQRCodeLabel: UILabel!
    @IBOutlet weak var monitorChargingLabel: UILabel!
    @IBOutlet weak var trackChargingProgressLabel: UILabel!
    @IBOutlet weak var makePaymentsLabel: UILabel!
    @IBOutlet weak var paySecurelyUsingCardsLabel: UILabel!
    @IBOutlet weak var viewChargingHistoryLabel: UILabel!
    @IBOutlet weak var checkPreviousChargingSessionsLabel: UILabel!
    @IBOutlet weak var stopChargingLabel: UILabel!
    @IBOutlet weak var stopChargingAnyTimeLabel: UILabel!
    @IBOutlet weak var saveFavouriteStationsLabel: UILabel!
    @IBOutlet weak var bookmarkFrequentlyUsedLabel: UILabel!
    @IBOutlet weak var getSupportLabel: UILabel!
    @IBOutlet weak var contactSupportAnytimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

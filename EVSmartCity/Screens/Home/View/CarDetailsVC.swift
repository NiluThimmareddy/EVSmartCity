//
//  CarDetailsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 26/05/26.
//

import UIKit

class CarDetailsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var carBrandTitleName: UILabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var chargingPercentLabel: UILabel!
    @IBOutlet weak var rangeKMLabel: UIButton!
    @IBOutlet weak var odometerLabel: UILabel!
    @IBOutlet weak var ValueKMLabel: UILabel!
    @IBOutlet weak var efficiencyLabel: UILabel!
    @IBOutlet weak var kwhPerHundredKMLabel: UILabel!
    @IBOutlet weak var batteryHealthLabel: UILabel!
    @IBOutlet weak var excellentConditionLabel: UILabel!
    @IBOutlet weak var batteryHealthPercentLabel: UILabel!
    @IBOutlet weak var batteryHealthProgressView: UIProgressView!
    @IBOutlet weak var chargingInfoLabel: UILabel!
    @IBOutlet weak var currentTariffLabel: UILabel!
    @IBOutlet weak var standardPublicNetworkLabel: UILabel!
    @IBOutlet weak var currentTarrifValueLabel: UILabel!
    @IBOutlet weak var maxChargingLimitLabel: UILabel!
    @IBOutlet weak var recommendedForDaileyUseLabel: UILabel!
    @IBOutlet weak var maxChargingValueLabel: UILabel!
    @IBOutlet weak var recentActivityLabel: UILabel!
    @IBOutlet weak var chargingStationNameLabel: UILabel!
    @IBOutlet weak var lastActivityLabel: UILabel!
    @IBOutlet weak var lastChargedSARValue: UILabel!
    @IBOutlet weak var energyAddedLabel: UILabel!
    @IBOutlet weak var addedEnergyKWHLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durtationTimeLabel: UILabel!
    @IBOutlet weak var energyUsageLabel: UILabel!
    @IBOutlet weak var thisWeekLabel: UILabel!
    @IBOutlet weak var kwhConsumedLabel: UILabel!
    @IBOutlet weak var barGraphConsumedKWHView: UIView!
    @IBOutlet weak var editVehicleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func editVehicleButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "EditVehicleSettingsVC") as! EditVehicleSettingsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}

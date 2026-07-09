//
//  ChargingLiveVC.swift
//  EVSmartCity
//
//  Created by Hitman on 06/07/26.
//

import UIKit

class ChargingLiveVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var chargingLiveLabel: UILabel!
    @IBOutlet weak var liveButton: UIButton!
    @IBOutlet weak var currentPowerView: UIView!
    @IBOutlet weak var ocppActiveButton: UIButton!
    @IBOutlet weak var updatedSecondsButton: UIButton!
    @IBOutlet weak var currentPowerDrawLabel: UILabel!
    @IBOutlet weak var currentPowerKWValueLabel: UILabel!
    @IBOutlet weak var kwLabel: UILabel!
    @IBOutlet weak var deliveredView: UIView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var costSoFarView: UIView!
    @IBOutlet weak var estSOCView: UIView!
    @IBOutlet weak var deliveredLabel: UILabel!
    @IBOutlet weak var deliveredKWHLabel: UILabel!
    @IBOutlet weak var signedMeterButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var estimateRemainingButton: UIButton!
    @IBOutlet weak var costSoFarLabel: UILabel!
    @IBOutlet weak var sarCostLabel: UILabel!
    @IBOutlet weak var inclVatTarrifButton: UIButton!
    @IBOutlet weak var estimateSOCLabel: UILabel!
    @IBOutlet weak var estimatePerLabel: UILabel!
    @IBOutlet weak var targetSocLabel: UIButton!
    @IBOutlet weak var socPercentLabel: UILabel!
    @IBOutlet weak var doneInMinutesLabel: UILabel!
    @IBOutlet weak var aiPredictLabel: UILabel!
    @IBOutlet weak var predictionAdaptsDynamicallyLabel: UILabel!
    @IBOutlet weak var tariffSARLabel: UILabel!
    @IBOutlet weak var peakRateLabel: UIButton!
    @IBOutlet weak var peakpricingActiveLabel: UILabel!
    @IBOutlet weak var savedCO2Label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var equivalentPlantingLabel: UILabel!
    @IBOutlet weak var smartChargingControlsLabel: UILabel!
    @IBOutlet weak var aiAutoLabel: UILabel!
    @IBOutlet weak var targetSocLimitLabel: UILabel!
    @IBOutlet weak var targetSocLimitPercentageLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    @IBOutlet weak var tenpercentLabel: UILabel!
    @IBOutlet weak var fiftyPercentLabel: UILabel!
    @IBOutlet weak var eightyPercentLabel: UILabel!
    @IBOutlet weak var hundredPercentLabel: UILabel!
    @IBOutlet weak var stopAfterTargetLabel: UILabel!
    @IBOutlet weak var targetEnergyKWLabel: UILabel!
    @IBOutlet weak var smartRecLabel: UILabel!
    @IBOutlet weak var targetCostLimitLabel: UILabel!
    @IBOutlet weak var costLimitSARLabel: UILabel!
    @IBOutlet weak var budgetSafeLabel: UILabel!
    @IBOutlet weak var smartTariffPauseLabel: UILabel!
    @IBOutlet weak var smartTariffSwitch: UISwitch!
    @IBOutlet weak var automaticallyPausesLabel: UILabel!
    @IBOutlet weak var chargerIDTitleLabel: UILabel!
    @IBOutlet weak var chargerLabel: UILabel!
    @IBOutlet weak var connectorTitleLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var stopChargingSessionButton: UIButton!
    @IBOutlet weak var smartChargingControlView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [currentPowerView,deliveredView,durationView,costSoFarView,estSOCView,smartChargingControlView].forEach { lightShadow in
            lightShadow?.applyLightShadow()
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func stopChargingSessionButtonAction(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(
            withIdentifier: "StopChargingVC"
        ) as! StopChargingVC

        vc.modalPresentationStyle = .pageSheet

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .init("fortyPercent")) { context in
                    context.maximumDetentValue * 0.3
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        present(vc, animated: true)
    }
    
    @IBAction func liveButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ChargingCompleteVC") as! ChargingCompleteVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}

//
//  ChargingCompleteVC.swift
//  EVSmartCity
//
//  Created by Hitman on 07/07/26.
//

import UIKit

class ChargingCompleteVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var chargingCompleteTitleButton: UILabel!
    @IBOutlet weak var chargingPortLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var finalSOCView: UIView!
    @IBOutlet weak var billingBreakdownLabel: UILabel!
    @IBOutlet weak var billingBreakdownView: UIView!
    @IBOutlet weak var ecoImpactLabel: UILabel!
    @IBOutlet weak var ecoImpactView: UIView!
    @IBOutlet weak var rewardsAndLoyaltyLabel: UILabel!
    @IBOutlet weak var rewardsAndLoyaltyView: UIView!
    @IBOutlet weak var rateThisStationLabel: UILabel!
    @IBOutlet weak var rateThisStationView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var finalSocLabel: UILabel!
    @IBOutlet weak var finalSocPercentLabel: UILabel!
    @IBOutlet weak var vehicleChangedLabel: UILabel!
    @IBOutlet weak var chargingCompleteLabel: UILabel!
    @IBOutlet weak var yourVehicleIsSafetyLabel: UILabel!
    @IBOutlet weak var kwPerHourValueLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var totalEnergyDeliveredLabel: UILabel!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var totalPaidView: UIView!
    @IBOutlet weak var avgPowerView: UIView!
    @IBOutlet weak var durationTitleLabel: UILabel!
    @IBOutlet weak var timeDurationLabel: UILabel!
    @IBOutlet weak var totalPaidTitleLabel: UILabel!
    @IBOutlet weak var totalPaidValueLabel: UILabel!
    @IBOutlet weak var sarLabel: UILabel!
    @IBOutlet weak var averagePowerTitleLabel: UILabel!
    @IBOutlet weak var averagePowerConsumedLabel: UILabel!
    @IBOutlet weak var invoiceSummaryLabel: UILabel!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var energyCostLabel: UILabel!
    @IBOutlet weak var energyCostConsumedLabel: UILabel!
    @IBOutlet weak var energyConsumptionLabel: UILabel!
    @IBOutlet weak var baseChargeLabel: UILabel!
    @IBOutlet weak var sessionFeeLabel: UILabel!
    @IBOutlet weak var sessionFeeConsumedLabel: UILabel!
    @IBOutlet weak var oneTimeConnectionFreeLabel: UILabel!
    @IBOutlet weak var fixedLabel: UILabel!
    @IBOutlet weak var idleFeeLabel: UILabel!
    @IBOutlet weak var idleFeeConsumedLabel: UILabel!
    @IBOutlet weak var zeroMintsOverstayLabel: UILabel!
    @IBOutlet weak var waivedLabel: UILabel!
    @IBOutlet weak var vatPercentLabel: UILabel!
    @IBOutlet weak var includedLabel: UILabel!
    @IBOutlet weak var onEnergySessionFeeLabel: UILabel!
    @IBOutlet weak var inTotalLabel: UILabel!
    @IBOutlet weak var totalPaidLabel: UILabel!
    @IBOutlet weak var totalPaidAmountLabel: UILabel!
    @IBOutlet weak var midCertifiedMeterLabel: UILabel!
    @IBOutlet weak var co2ImpactThisSessionlabel: UILabel!
    @IBOutlet weak var co2SavedKGsLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var equivalentPetrolVehicleLabel: UILabel!
    @IBOutlet weak var kmRangeLabel: UILabel!
    @IBOutlet weak var kmRangeProgressView: UIProgressView!
    @IBOutlet weak var equivalentToPlantingLabel: UILabel!
    @IBOutlet weak var loyaltyPointsLabel: UILabel!
    @IBOutlet weak var pointsEarnedValueLabel: UILabel!
    @IBOutlet weak var ptsEarnedLabel: UILabel!
    @IBOutlet weak var pointsPercentLabel: UILabel!
    @IBOutlet weak var pointsProgressView: UIProgressView!
    @IBOutlet weak var morePointsToReachPlatinumLabel: UILabel!
    @IBOutlet weak var goldMemberButton: UIButton!
    @IBOutlet weak var ecoChampionButton: UIButton!
    @IBOutlet weak var fastChargerButton: UIButton!
    @IBOutlet weak var howWasYourExperienceLabel: UILabel!
    @IBOutlet weak var rateThisChargerLabel: UILabel!
    @IBOutlet var ratingStarsButton: [UIButton]!
    @IBOutlet weak var addOptionalFeedbackTF: UITextField!
    @IBOutlet weak var fastChargerRatingButton: UIButton!
    @IBOutlet weak var worksGreatButton: UIButton!
    @IBOutlet weak var easyParkingButton: UIButton!
    @IBOutlet weak var cleanAreaButton: UIButton!
    @IBOutlet weak var sessionRefLabel: UILabel!
    @IBOutlet weak var sessionRefIDLabel: UILabel!
    @IBOutlet weak var pdfReceiptButton: UIButton!
    @IBOutlet weak var doneBackToHomeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [finalSOCView,billingBreakdownView,ecoImpactView,rewardsAndLoyaltyView,rateThisStationView].forEach { shadow in
            shadow.applyLightShadow()
        }        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        finalSOCView.layoutIfNeeded()
        ecoImpactView.layoutIfNeeded()

        finalSOCView.applyLightGreenGradient()
        ecoImpactView.applyLightGreenGradient()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func pdfReceiptButtonAction(_ sender: Any) {
    }
    
    @IBAction func doneBackToHomeButtonAction(_ sender: Any) {
    }
    
}

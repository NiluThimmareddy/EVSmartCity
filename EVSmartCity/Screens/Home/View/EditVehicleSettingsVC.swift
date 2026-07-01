//
//  EditVehicleSettingsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 25/06/26.
//

import UIKit

class EditVehicleSettingsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editVehicleSettingsLabel: UILabel!
    @IBOutlet weak var currentVehicleImgView: UIImageView!
    @IBOutlet weak var currentVehicleModelLabel: UILabel!
    @IBOutlet weak var currentVehicleLabel: UILabel!
    @IBOutlet weak var vehicleInformationLabel: UILabel!
    @IBOutlet weak var vehicleNameTitleLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var vehicleModelTitleLabel: UILabel!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var chargingSettingsLabel: UILabel!
    @IBOutlet weak var maxChargeLimitLabel: UILabel!
    @IBOutlet weak var chargingLimitPercentLabel: UILabel!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var fiftyPercentLabel: UILabel!
    @IBOutlet weak var hundredPercentLabel: UILabel!
    @IBOutlet weak var defaultConnectorLabel: UILabel!
    @IBOutlet weak var recommendedForYourModelLabel: UILabel!
    @IBOutlet weak var connectorTypesButton: UIButton!
    @IBOutlet weak var batteryProtectionLabel: UILabel!
    @IBOutlet weak var limitsChargingToImproveBatteryLifeLabel: UILabel!
    @IBOutlet weak var batteryProtectionSwitch: UISwitch!
    @IBOutlet weak var smartChargingTitleLabel: UILabel!
    @IBOutlet weak var smartChargingLabel: UILabel!
    @IBOutlet weak var automaticallyChargeDuringOffPeekTimeLabel: UILabel!
    @IBOutlet weak var smartCharingSwitch: UISwitch!
    @IBOutlet weak var notificationsTitleLabel: UILabel!
    @IBOutlet weak var chargingCompleteLabel: UILabel!
    @IBOutlet weak var chargingCompleteSwitch: UISwitch!
    @IBOutlet weak var lowBatteryAlertsLabel: UILabel!
    @IBOutlet weak var lowBatteryAlertsSwitch: UISwitch!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    let connectorTypes = ["Type 1 (J1772)","Type 2 (Mennekes)","CCS 1","CCS 2","CHAdeMO","GB/T","Tesla NACS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConnectorMenu()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveChangesButtonAction(_ sender: Any) {
    }
    
    func setupConnectorMenu() {
        let actions = connectorTypes.map { connector in
            UIAction(title: connector) { [weak self] _ in
                self?.connectorTypesButton.setTitle(connector, for: .normal)
            }
        }
        connectorTypesButton.menu = UIMenu(
            title: "Select Connector Type",
            children: actions
        )
        connectorTypesButton.showsMenuAsPrimaryAction = true
        connectorTypesButton.changesSelectionAsPrimaryAction = false
    }
}

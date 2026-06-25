//
//  VehicalAddedSuccessfullyVC.swift
//  EVSmartCity
//
//  Created by Hitman on 05/05/26.
//

import UIKit

class VehicleAddedSuccessfullyVC : UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var vehicleAddedSuccessfullyLabel: UILabel!
    @IBOutlet weak var yourTeslaModelAddedLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var addAnotherVehicleButton: UIButton!
    @IBOutlet weak var primararyVehicleLabel: UILabel!
    @IBOutlet weak var boltView: UIView!
    @IBOutlet weak var readyForFastChargingLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var electricLabel: UILabel!
    @IBOutlet weak var batteryPercentageLabel: UILabel!
    @IBOutlet weak var batteryStatusLabel: UILabel!
    @IBOutlet weak var capacityTitleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var rangeTitleLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var connectorTypeTitleLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var chargingTitleLabel: UILabel!
    @IBOutlet weak var chargingStatusLabel: UILabel!
    @IBOutlet weak var readyToChargeButton: UIButton!
    @IBOutlet weak var completeWithNearbyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.applyShadow()
        boltView.applyShadow()
        carImgView.layer.cornerRadius = 20
        carImgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        carImgView.clipsToBounds = true
        primararyVehicleLabel.clipsToBounds = true
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func readyToChargeButtonAction(_ sender: Any) {
    }
    
    @IBAction func addAnotherVehicleButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddYourVehicleVC") as! AddYourVehicleVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
}

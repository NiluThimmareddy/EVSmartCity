//
//  VehicleManageVC.swift
//  EVSmartCity
//
//  Created by Hitman on 16/06/26.
//

import UIKit

class VehicleManageVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var insideScrollview: UIView!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var vehicleManageTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var activeStatusLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var electricSedanTitleLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var connectorTitleLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var capacityTitleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var acChargeTitleLabel: UILabel!
    @IBOutlet weak var acChargeKWLabel: UILabel!
    @IBOutlet weak var dcFastChargetitleLabel: UILabel!
    @IBOutlet weak var dcChargeKWLabel: UILabel!
    @IBOutlet weak var linkedRifdCardLabel: UILabel!
    @IBOutlet weak var linkedRFIDCardCollectionView: UICollectionView!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var otherVehiclesLabel: UILabel!
    @IBOutlet weak var inactiveCarImgView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var inactiveStatuslabel: UILabel!
    @IBOutlet weak var vehicleInfoLabel: UILabel!
    @IBOutlet weak var setAsActiveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeStatusLabel.clipsToBounds = true
        inactiveStatuslabel.clipsToBounds = true
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
    }
    
    @IBAction func viewDetailsButtobnAction(_ sender: Any) {
    }
    
    @IBAction func removeButtonAction(_ sender: Any) {
    }
    
    @IBAction func setAsActiveButtonAction(_ sender: Any) {
    }
    
}

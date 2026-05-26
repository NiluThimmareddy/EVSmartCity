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
    @IBOutlet weak var numberplateLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addAnotherVehicleButton: UIButton!
    @IBOutlet weak var chargingPercentButton: UIButton!
    @IBOutlet weak var primararyVehicleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var boltView: UIView!
    @IBOutlet weak var readyForFastChargingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.applyShadow()
        boltView.applyShadow()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FilterPageVC") as! FilterPageVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func addAnotherVehicleButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddAnotherVechileVC") as! AddAnotherVechileVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
}

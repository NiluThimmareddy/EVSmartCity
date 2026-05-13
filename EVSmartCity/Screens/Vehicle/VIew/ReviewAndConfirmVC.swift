//
//  ReviewAndConfirmVC.swift
//  EVSmartCity
//
//  Created by Hitman on 05/05/26.
//

import UIKit

class ReviewAndConfirmVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButtonAction: UIButton!
    @IBOutlet weak var reviewAndConfirmLabel: UILabel!
    @IBOutlet weak var step4of4Label: UILabel!
    @IBOutlet weak var reviewYourVehicleLabel: UILabel!
    @IBOutlet weak var pleaseConfirmYourVehicleDetailsLabel: UILabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var connectorLabel: UILabel!
    @IBOutlet weak var connecterTypeLabel: UILabel!
    @IBOutlet weak var numberPlateLabel: UILabel!
    @IBOutlet weak var nickNameTitleLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var vehicleDetailsView: UIView!
    @IBOutlet weak var carView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleDetailsView.applyShadow()
        carView.layer.cornerRadius = 20
        carView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        carView.layer.masksToBounds = true
    }
 
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddAnotherVechileVC") as! AddAnotherVechileVC
        storyboard.isEditMode = true
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "VehicleAddedSuccessfullyVC") as! VehicleAddedSuccessfullyVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

//
//  AddVehicleTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//
/*
import UIKit

class AddVehicleTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var brandImgView: UIImageView!
    @IBOutlet weak var vehicleBrandNameLabel: UILabel!
    @IBOutlet weak var checkMarkIButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
*/

import UIKit

class AddVehicleTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var brandImgView: UIImageView!
    @IBOutlet weak var vehicleBrandNameLabel: UILabel!
    @IBOutlet weak var checkMarkIButton: UIButton!
    
    let greenColor = UIColor(hex: "#379D67")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
        
        resetUI()
    }
    
    func configure(isSelected: Bool) {
        if isSelected {
            applySelectedUI()
        } else {
            resetUI()
        }
    }
    
    func applySelectedUI() {
        backView.backgroundColor = greenColor.withAlphaComponent(0.1)
        backView.layer.borderWidth = 0.5
        backView.layer.borderColor = greenColor.cgColor
        
        vehicleBrandNameLabel.textColor = greenColor
        
        checkMarkIButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkMarkIButton.tintColor = greenColor
    }
    
    func resetUI() {
        backView.backgroundColor = .clear
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.clear.cgColor
        vehicleBrandNameLabel.textColor = .label
        checkMarkIButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkMarkIButton.tintColor = UIColor.lightGray
    }
}

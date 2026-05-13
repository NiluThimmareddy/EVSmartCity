//
//  VehicleColorCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 12/05/26.
//

import UIKit

class VehicleColorCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var colourView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colourView.applyShadow()
    }

}

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
    @IBOutlet weak var plusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colourView.applyShadow()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colourView.layer.cornerRadius = colourView.frame.height / 2
        colourView.clipsToBounds = true
        plusLabel.textAlignment = .center
    }
}

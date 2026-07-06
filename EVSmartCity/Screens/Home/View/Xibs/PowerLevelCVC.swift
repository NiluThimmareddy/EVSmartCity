//
//  PowerLevelCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 01/07/26.
//

import UIKit

class PowerLevelCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var chargerTypeLabel: UILabel!
    @IBOutlet weak var chargerPowerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(isSelected: Bool) {
        if isSelected {
            backView.backgroundColor = UIColor(hex: "#379D67")
            chargerTypeLabel.textColor = .white
            chargerPowerLabel.textColor = .white
            backView.layer.borderColor = UIColor.clear.cgColor
        } else {
            backView.backgroundColor = .systemBackground
            chargerTypeLabel.textColor = .label
            chargerPowerLabel.textColor = .secondaryLabel
            backView.layer.borderColor = UIColor.systemGray2.cgColor
        }
    }
}

//
//  QuickHelpCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.
//

import UIKit

class QuickHelpCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyShadow()
    }
    
    func configure(model : QuickHelpItem) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }

}

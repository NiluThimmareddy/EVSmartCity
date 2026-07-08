//
//  CardAndPlugTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 06/07/26.
//

import UIKit

class CardAndPlugTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyLightShadow()
    }
    
    func configure(_with option: CardAndPlugOption) {
        iconImgView.image = option.icon
        titleLabel.text = option.title
        descriptionlabel.text = option.description

        if let status = option.status {
            statusLabel.text = status
            statusLabel.isHidden = false
        } else {
            statusLabel.isHidden = true
        }
    }
}

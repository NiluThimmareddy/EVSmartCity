//
//  SortOrderTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 16/07/26.
//

import UIKit

class SortOrderTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var premiumLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var circleImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        premiumLabel.layer.masksToBounds = true
    }
    
    func configure(with sort:  SortOption,isSelected: Bool,showPremium: Bool) {
        titleLabel.text = sort.title
        descriptionlabel.text = sort.description
        premiumLabel.isHidden = !showPremium

        if isSelected {
            circleImgView.image = UIImage(systemName: "checkmark.circle.fill")
            circleImgView.tintColor = UIColor(hex: "#379D67")
        } else {
            circleImgView.image = UIImage(systemName: "circle")
            circleImgView.tintColor = UIColor(hex: "#575757")
        }
    }
    
    func configure(with language: LanguageModel,isSelected: Bool,showPremium: Bool) {
        titleLabel.text = language.nativeName
        descriptionlabel.text = language.englishName
        premiumLabel.isHidden = !showPremium

        if isSelected {
            circleImgView.image = UIImage(systemName: "checkmark.circle.fill")
            circleImgView.tintColor = UIColor(hex: "#379D67")
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor(hex: "#006B32").cgColor
        } else {
            circleImgView.image = UIImage(systemName: "circle")
            circleImgView.tintColor = UIColor(hex: "#575757")
            backView.layer.borderWidth = 0
            backView.layer.borderColor = UIColor.clear.cgColor
        }
    }

}

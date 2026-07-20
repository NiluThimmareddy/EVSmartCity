//
//  SelectCategoryCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 17/07/26.
//

import UIKit

class SelectCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: Category, isSelected: Bool) {
        titleLabel.text = model.name
        iconImgView.image = UIImage(systemName: model.icon)

        let greenColor = UIColor(hex: "#379D67")
        let darkColor = UIColor(hex: "#0F1724")

        if isSelected {
            backView.backgroundColor = greenColor
            titleLabel.textColor = .white
            iconImgView.tintColor = .white
            backView.layer.borderWidth = 0
        } else {
            backView.backgroundColor = .white
            titleLabel.textColor = darkColor
            iconImgView.tintColor = greenColor

            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.systemGray4.cgColor
        }

        backView.layer.cornerRadius = 16
    }
}

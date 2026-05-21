//
//  WhatTypeOfIssueCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 20/05/26.
//

//import UIKit
//
//class WhatTypeOfIssueCVC: UICollectionViewCell {
//
//    @IBOutlet weak var backView: UIView!
//    @IBOutlet weak var iconImgView: UIImageView!
//    @IBOutlet weak var issueTitleLabel: UILabel!
//    @IBOutlet weak var circleImgView: UIImageView!
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    
//    func configure(with : IssueModel) {
//        iconImgView.image = UIImage(systemName: with.iconName)
//        issueTitleLabel.text = with.title
//    }
//}

import UIKit

class WhatTypeOfIssueCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var circleImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSelected(false)
    }
    
    func configure(with issue: IssueModel) {
        iconImgView.image = UIImage(systemName: issue.iconName)
        issueTitleLabel.text = issue.title
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            backView.backgroundColor = UIColor(hex: "379D67").withAlphaComponent(0.1)
            backView.layer.borderColor = UIColor(hex: "379D67").cgColor
            backView.layer.borderWidth = 1
            iconImgView.tintColor = UIColor(hex: "379D67")
            issueTitleLabel.textColor = UIColor(hex: "379D67")
            circleImgView.image = UIImage(systemName: "dot.circle")
            circleImgView.tintColor = UIColor(hex: "379D67")
        } else {
            backView.backgroundColor = .clear
            backView.layer.borderColor = UIColor.systemGray3.cgColor
            backView.layer.borderWidth = 0.5
            iconImgView.tintColor = .label
            issueTitleLabel.textColor = .label
            circleImgView.image = UIImage(systemName: "circle")
            circleImgView.tintColor = .systemGray
        }
    }
}

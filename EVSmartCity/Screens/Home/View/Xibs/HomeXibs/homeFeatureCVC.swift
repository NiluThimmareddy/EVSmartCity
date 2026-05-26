//
//  homeFeatureCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 25/05/26.
//

import UIKit

class homeFeatureCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with: HomeFeaturesModel) {
        iconImgView.image = UIImage(systemName: with.imageName)
        titleLabel.text = with.title
    }
}

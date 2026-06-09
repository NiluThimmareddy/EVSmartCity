//
//  AmenitiesCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/06/26.
//

import UIKit

class AmenitiesCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with item : Amenity) {
        iconImgView.image = UIImage(systemName: item.iconName)
    }
}

//
//  UploadEvidenceCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 20/07/26.
//

import UIKit

class UploadEvidenceCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var uplodedImgView: UIImageView!
    @IBOutlet weak var addImgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addImgLabel.layer.masksToBounds = true
        addImgLabel.addDashedBorder()
    }

    func configure(image: UIImage?) {
        if let image = image {
            uplodedImgView.image = image
            uplodedImgView.isHidden = false
            addImgLabel.isHidden = true
        } else {
            uplodedImgView.isHidden = true
            addImgLabel.isHidden = false
        }
    }
}

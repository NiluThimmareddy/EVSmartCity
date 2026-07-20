//
//  AttachedEvidenceCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 20/07/26.
//

import UIKit

class AttachedEvidenceCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var evidenceImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_with image : AttachedEvidence) {
        evidenceImgView.image = UIImage(named: image.image)
    }

}

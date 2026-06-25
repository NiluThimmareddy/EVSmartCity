//
//  RFIDCollectionViewCell.swift
//  EVSmartCity
//
//  Created by Hitman on 18/06/26.
//

import UIKit

class RFIDCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rfidLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        backView.layer.cornerRadius = backView.frame.height / 2
        backView.clipsToBounds = true
    }
}

//
//  NeedMoreHelpTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.
//

import UIKit

class NeedMoreHelpTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(model: QuickHelpItem, isFirstRow: Bool) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        availableLabel.isHidden = !isFirstRow
    }
}

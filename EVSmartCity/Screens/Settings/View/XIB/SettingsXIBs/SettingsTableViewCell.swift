//
//  SettingsTableViewCell.swift
//  EVSmartCity
//
//  Created by Hitman on 13/07/26.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: SettingItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        iconImageView.image = UIImage(systemName: item.iconName)
    }
    
}

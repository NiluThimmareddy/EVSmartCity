//
//  ConnectorTypesCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 06/05/26.
//

import UIKit

class ConnectorTypesCVC: UICollectionViewCell {

    @IBOutlet weak var connectorTypeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        connectorTypeButton.backgroundColor = .white
        connectorTypeButton.setTitleColor(.darkGray, for: .normal)
        connectorTypeButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupCell() {

        connectorTypeButton.titleLabel?.numberOfLines = 1
        connectorTypeButton.titleLabel?.textAlignment = .center
        connectorTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        connectorTypeButton.titleLabel?.lineBreakMode = .byClipping
        connectorTypeButton.titleLabel?.adjustsFontSizeToFitWidth = false
        connectorTypeButton.titleLabel?.minimumScaleFactor = 1.0

        connectorTypeButton.setTitleColor(.darkGray, for: .normal)
        connectorTypeButton.isUserInteractionEnabled = false

        connectorTypeButton.layer.cornerRadius = 25
        connectorTypeButton.layer.borderWidth = 1.5
        connectorTypeButton.layer.borderColor = UIColor.lightGray.cgColor
        connectorTypeButton.backgroundColor = .white
    }
    
    func configure(with title: String) {
        connectorTypeButton.setTitle(title, for: .normal)
    }
    
    func setSelected(_ isSelected: Bool) {
        let imageName = isSelected ? "ic_connectorIcon1" : "ic_connectorIcon"
        connectorTypeButton.setImage(UIImage(named: imageName), for: .normal)
        if isSelected {
            connectorTypeButton.backgroundColor = UIColor(hex: "379D67")
            connectorTypeButton.setTitleColor(.white, for: .normal)
            connectorTypeButton.layer.borderColor = UIColor(hex: "379D67").cgColor
        } else {
            connectorTypeButton.backgroundColor = .white
            connectorTypeButton.setTitleColor(.darkGray, for: .normal)
            connectorTypeButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}

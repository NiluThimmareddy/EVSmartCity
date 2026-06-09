//
//  ConnectorsCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/06/26.
//

import UIKit

class ConnectorsCVC: UICollectionViewCell {

    @IBOutlet weak var connectorTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with connectorType: ConnectorsTypes) {
        connectorTypeLabel.text = connectorType.rawValue
    }
}

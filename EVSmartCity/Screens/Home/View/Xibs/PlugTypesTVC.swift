//
//  PlugTypesTVC.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import UIKit

class PlugTypesTVC: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var plugTypeLabel: UILabel!
    @IBOutlet weak var plugsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backView.layer.cornerRadius = 8
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.systemGray4.cgColor
        backView.layer.masksToBounds = true
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with connector: ConnectorCellViewModel) {
        // Use the new ConnectorCellViewModel properties
        let connectorIcon: String
        switch connector.type {
        case "Type 2":
            connectorIcon = "🔌"
        case "CCS2":
            connectorIcon = "⚡"
        case "CHAdeMO":
            connectorIcon = "🔋"
        default:
            connectorIcon = "⚡"
        }
        
        plugTypeLabel.text = "\(connectorIcon) \(connector.type)"
        plugsCountLabel.text = "\(connector.plugsCount) plug\(connector.plugsCount > 1 ? "s" : "")"
        
        // Use the statusColor from view model
        let backgroundColor: UIColor
        switch connector.status {
        case "Available":
            backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        case "Busy":
            backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        default:
            backgroundColor = UIColor.systemGray5
        }
        
        backView.backgroundColor = backgroundColor
        
        // Optional: Change border color based on status
        let borderColor: UIColor
        switch connector.status {
        case "Available":
            borderColor = UIColor.systemGreen.withAlphaComponent(0.3)
        case "Busy":
            borderColor = UIColor.systemOrange.withAlphaComponent(0.3)
        default:
            borderColor = UIColor.systemGray4
        }
        
        backView.layer.borderColor = borderColor.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        plugTypeLabel.text = nil
        plugsCountLabel.text = nil
        backView.backgroundColor = .clear
        backView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

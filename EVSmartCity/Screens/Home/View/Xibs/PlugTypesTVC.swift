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
    
    func configure(with viewModel: ConnectorCellViewModel) {
        let connectorIcon: String
        switch viewModel.connector.type {
        case "Type 2":
            connectorIcon = "🔌"
        case "CCS2":
            connectorIcon = "⚡"
        case "CHAdeMO":
            connectorIcon = "🔋"
        default:
            connectorIcon = "⚡"
        }
        plugTypeLabel.text = "\(connectorIcon) \(viewModel.connector.type)"
        plugsCountLabel.text = "\(viewModel.connector.plugs) plug\(viewModel.connector.plugs > 1 ? "s" : "")"
        let backgroundColor: UIColor
        switch viewModel.connector.status {
        case "Available":
            backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        case "Busy":
            backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        default:
            backgroundColor = UIColor.systemGray5
        }
        backView.backgroundColor = backgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        plugTypeLabel.text = nil
        plugsCountLabel.text = nil
        backView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

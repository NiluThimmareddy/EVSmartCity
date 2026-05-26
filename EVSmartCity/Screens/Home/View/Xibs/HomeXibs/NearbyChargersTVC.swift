//
//  NearbyChargersTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 25/05/26.
//

import UIKit

class NearbyChargersTVC : UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationDescriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var freeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with data: ChargingStationModel) {
        
        iconImgView.image = UIImage(systemName: data.stationImage)
        
        stationNameLabel.text = data.stationName
        
        stationDescriptionLabel.text =
        "\(data.stationType) • \(data.powerOutput) • \(data.plugs) • \(data.status)"
        
        distanceLabel.text = data.distance
        
        freeLabel.text = data.availableSlots
        
        if data.availableColor == "systemOrange" {
            
            statusView.backgroundColor = .systemOrange
            
            colourView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
            
            iconImgView.tintColor = .systemOrange
            
        } else {
            
            statusView.backgroundColor = UIColor(hex: "#379D67")
            
            colourView.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            
            iconImgView.tintColor = UIColor(hex: "#379D67")
        }
    }
    
}

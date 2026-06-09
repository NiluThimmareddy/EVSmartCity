//
//  FavouriteStationsTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 02/06/26.
//

import UIKit

class FavouriteStationsTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var stationnameLabel: UILabel!
    @IBOutlet weak var stationAddressLabel: UILabel!
    @IBOutlet weak var dcOrAcLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var acDCView: UIView!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func goButtonAction(_ sender: Any) {
    }
    
    func configure(stationsdata : FavouriteChargingStationModel) {
        stationnameLabel.text = stationsdata.stationName
        stationAddressLabel.text = stationsdata.stationAddress
        dcOrAcLabel.text = stationsdata.stationType
        distanceLabel.text = stationsdata.distance
        availabilityLabel.text = stationsdata.availability
        
        if stationsdata.stationType.lowercased() == "ac" {
            acDCView.backgroundColor = UIColor(hex: "#EBF2FF")
            dcOrAcLabel.textColor = UIColor(hex: "#1D4ED8")
        } else if stationsdata.stationType.lowercased() == "dc fast" {
            acDCView.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            dcOrAcLabel.textColor = UIColor(hex: "#379D67")
        }
    }
    
}

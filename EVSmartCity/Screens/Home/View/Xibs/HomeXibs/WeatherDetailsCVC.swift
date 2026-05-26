//
//  WeatherDetailsCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 25/05/26.
//

import UIKit

class WeatherDetailsCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var batteryAlertButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyOrangeGradient()
    }

}

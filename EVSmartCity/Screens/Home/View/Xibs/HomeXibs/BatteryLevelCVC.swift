//
//  BatteryLevelCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 25/05/26.
//

import UIKit

class BatteryLevelCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryPercentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var rangeKMLeftLabel: UILabel!
    @IBOutlet weak var estimateFullTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

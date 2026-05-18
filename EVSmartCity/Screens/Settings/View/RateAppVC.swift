//
//  RateAppVC.swift
//  EVSmartCity
//
//  Created by Hitman on 15/05/26.
//

import UIKit

class RateAppVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var enjoyEvSaudiLabel: UILabel!
    @IBOutlet weak var tapStarToRateLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var rateNowButton: UIButton!
    @IBOutlet weak var mayBeLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.applyShadow()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    @IBAction func rateNowButtonAction(_ sender: Any) {
    }
    
    @IBAction func mayBeLaterButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

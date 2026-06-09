//
//  OffersVC.swift
//  EVSmartCity
//
//  Created by Hitman on 03/06/26.
//

import UIKit

class OffersVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var offersTitleLabel: UILabel!
    @IBOutlet weak var offerImgView: UIImageView!
    @IBOutlet weak var offerTypebutton: UIButton!
    @IBOutlet weak var offerPercentageLabel: UILabel!
    @IBOutlet weak var fastChargingThisWeeklabel: UILabel!
    @IBOutlet weak var useCodeLabel: UILabel!
    @IBOutlet weak var offerCodeView: UIView!
    @IBOutlet weak var offerCodeLabel: UILabel!
    @IBOutlet weak var enjoyPercentOfflabel: UILabel!
    @IBOutlet weak var getPercentOffOnAllFastChagingLabel: UILabel!
    @IBOutlet weak var offerValidityLabel: UILabel!
    @IBOutlet weak var offerValidityDatesLabel: UILabel!
    @IBOutlet weak var howitWorksLabel: UILabel!
    @IBOutlet weak var useTheCodeWhileStartingChargingLabel: UILabel!
    @IBOutlet weak var shareTheJoyLabel: UILabel!
    @IBOutlet weak var shareThisOfferWithYOurFriendsLabel: UILabel!
    @IBOutlet weak var shareOfferButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offerCodeLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(copyOfferCode))
        offerCodeLabel.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        offerCodeView.addDashedBorder(color: UIColor(hex: "#379D67"))
    }
    
    @objc func copyOfferCode() {
        guard let code = offerCodeLabel.text, !code.isEmpty else { return }

        UIPasteboard.general.string = code

        showToast(message: "Copied to clipboard")
    }
    
    @IBAction func backbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareOfferButtonAction(_ sender: Any) {
    }
    
}

//
//  CurrentRatesVC.swift
//  EVSmartCity
//
//  Created by Hitman on 03/06/26.
//

import UIKit

class CurrentRatesVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backbuttonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

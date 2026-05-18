//
//  LiveChartVC.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.
//

import UIKit

class LiveChartVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var liveChartLabel: UILabel!
    @IBOutlet weak var connectedSupportLabel: UILabel!
    @IBOutlet weak var ourSupportTeamLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var attachFilesButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var typeAMessageTF: UITextField!
    @IBOutlet weak var messagesTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func attachFilesButtonAction(_ sender: Any) {
    }
    
    @IBAction func sendMessageButtonAction(_ sender: Any) {
    }
    
}



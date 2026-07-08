//
//  StartChargingVC.swift
//  EVSmartCity
//
//  Created by Hitman on 06/07/26.
//

import UIKit

class StartChargingVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startChargingTitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UIButton!
    @IBOutlet weak var chooseChargingMethod: UILabel!
    @IBOutlet weak var securelyConnectLabel: UILabel!
    @IBOutlet weak var cardAndPlugTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var manualEntryLabel: UILabel!
    @IBOutlet weak var forDamagedOrUnavailableLabel: UILabel!
    @IBOutlet weak var stationIdLabel: UILabel!
    @IBOutlet weak var enterStationIdentifierLabel: UILabel!
    @IBOutlet weak var stationIDTF: UITextField!
    @IBOutlet weak var connectorIDLabel: UILabel!
    @IBOutlet weak var selectChargingConnectorLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UITextField!
    @IBOutlet weak var startChargingButton: UIButton!
    
    let options: [CardAndPlugOption] = [
        CardAndPlugOption(icon: UIImage(systemName:"qrcode"),title: "Tap RFID Card",description: "Use your linked charging card.",
            status: nil),
        CardAndPlugOption(icon: UIImage(systemName: "ev.plug.ac.gb.t"),title: "Plug & Charge",description: "Automatic vehicle authentication.",
            status: "ISO 15118")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardAndPlugTableView.register(UINib(nibName: "CardAndPlugTVC", bundle: nil), forCellReuseIdentifier: "CardAndPlugTVC")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func questionButtonAction(_ sender: Any) {
    }
    
    @IBAction func startChargingButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ChargingLiveVC") as! ChargingLiveVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

extension StartChargingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardAndPlugTVC") as! CardAndPlugTVC
        let option = options[indexPath.row]
        cell.configure(_with: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

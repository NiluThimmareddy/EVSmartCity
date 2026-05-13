//
//  PermissionsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 13/05/26.
//

import UIKit

class PermissionsVC: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var permissionsLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationSwith: UISwitch!
    @IBOutlet weak var allowAccessToLocationLabel: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var allowNotificationsLabel: UILabel!
    @IBOutlet weak var yourPrivacymatterLabel: UILabel!
    @IBOutlet weak var weOnlyRequestPermissionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonAction(_ sender: Any) {
    }
    
    @IBAction func locationSwitchAction(_ sender: Any) {
    }
    
    @IBAction func notificationsSwitchAction(_ sender: Any) {
    }
    
}

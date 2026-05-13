//
//  DonotRecognizeDeviceVC.swift
//  EVSmartCity
//
//  Created by Hitman on 13/05/26.
//

import UIKit

class DonotRecognizeDeviceVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dontRecognizeLabel: UILabel!
    @IBOutlet weak var ifYouSeeAnUnfamiliarLabel: UILabel!
    @IBOutlet weak var thisWillProtectYourAccountLabel: UILabel!
    @IBOutlet weak var changePasswordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordTableView.register(UINib(nibName: "DonotRecognizeDeviceTVC", bundle: nil), forCellReuseIdentifier: "DonotRecognizeDeviceTVC")

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension DonotRecognizeDeviceVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonotRecognizeDeviceTVC") as! DonotRecognizeDeviceTVC
        cell.imgView?.image = UIImage(systemName: "lock")
        cell.dontRecognizeLabel.text = "Change Password"
        cell.ifYouSeeAnyLabel.text = "Create a strong new password to keep your account safe."
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Biometric", bundle: nil).instantiateViewController(withIdentifier: "ChangePasscodeVC") as! ChangePasscodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

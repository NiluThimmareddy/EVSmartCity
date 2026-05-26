//
//  ReportSubmittedSuccessfullyVC.swift
//  EVSmartCity
//
//  Created by Hitman on 21/05/26.
//

import UIKit

class ReportSubmittedSuccessfullyVC: UIViewController {
    
    var timer: Timer?
    var countdown = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        countdown -= 1
        
        if countdown <= 0 {
            timer?.invalidate()
            timer = nil
            navigateToLoginVC()
        }
    }
    
    func navigateToLoginVC() {
        if let reportAnIssueVC = self.presentingViewController as? ReportAnIssueVC {
            self.dismiss(animated: true) {
                reportAnIssueVC.dismiss(animated: true) {
                    self.presentLoginVC()
                }
            }
        } else {
            self.dismiss(animated: true) {
                self.presentLoginVC()
            }
        }
    }
    
    func presentLoginVC() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            loginVC.modalPresentationStyle = .fullScreen
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(loginVC, animated: true)
            }
        }
    }
}

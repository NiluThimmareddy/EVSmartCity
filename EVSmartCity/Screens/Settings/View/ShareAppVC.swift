//
//  ShareAppVC.swift
//  EVSmartCity
//
//  Created by Hitman on 15/05/26.
//
/*
import UIKit

class ShareAppVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareAppLabel: UILabel!
    @IBOutlet weak var inviteYourFriendsLabel: UILabel!
    @IBOutlet weak var chargeSmarterWithEVLabel: UILabel!
    @IBOutlet weak var shareViaLabel: UILabel!
    @IBOutlet weak var whatsAppButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var whatsApplabel: UILabel!
    @IBOutlet weak var messagesLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var orCopyLinkLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyLinkCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
    }
    
    @IBAction func whatsAppButtonAction(_ sender: Any) {
    }
    
    @IBAction func messagesButtonAction(_ sender: Any) {
    }
    
    @IBAction func emailButtonAction(_ sender: Any) {
    }
    
    @IBAction func copyLinkCodeButtonAction(_ sender: Any) {
    }

}
*/

import UIKit

class ShareAppVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareAppLabel: UILabel!
    @IBOutlet weak var inviteYourFriendsLabel: UILabel!
    @IBOutlet weak var chargeSmarterWithEVLabel: UILabel!
    @IBOutlet weak var shareViaLabel: UILabel!
    @IBOutlet weak var whatsAppButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var whatsApplabel: UILabel!
    @IBOutlet weak var messagesLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var orCopyLinkLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyLinkCodeButton: UIButton!
    
    let appLink = "https://apps.apple.com/app/idYOUR_APP_ID"
    let shareMessage = "Check out this awesome EV charging app! Download it here: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkLabel.text = appLink
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func whatsAppButtonAction(_ sender: Any) {
        let fullMessage = "\(shareMessage)\(appLink)"
        let urlString = "whatsapp://send?text=\(fullMessage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showAlert(message: "WhatsApp is not installed on your device")
            }
        }
    }
    
    @IBAction func messagesButtonAction(_ sender: Any) {
        let fullMessage = "\(shareMessage)\(appLink)"
        let activityVC = UIActivityViewController(activityItems: [fullMessage], applicationActivities: nil)
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func emailButtonAction(_ sender: Any) {
        let subject = "Check out this EV Charging App!"
        let body = "Hi,\n\nI wanted to share this amazing EV charging app with you.\n\n\(shareMessage)\(appLink)\n\nCheers!"
        
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let emailURLString = "mailto:?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        if let emailURL = URL(string: emailURLString) {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            } else {
                showAlert(message: "Email app is not configured on your device")
            }
        }
    }
    
    @IBAction func copyLinkCodeButtonAction(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = appLink
        showToast(message: "Link copied to clipboard", duration: 2.0, position: .bottom)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

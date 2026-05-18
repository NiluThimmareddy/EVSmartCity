//
//  SupportAndHelpVC.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.
//

import UIKit

class SupportAndHelpVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var supportAndHelpLabel: UILabel!
    @IBOutlet weak var weAreHereToHelpLabel: UILabel!
    @IBOutlet weak var howCanWeHelplabel: UILabel!
    @IBOutlet weak var getQuickAnswersLabel: UILabel!
    @IBOutlet weak var liveChatButton: UIButton!
    @IBOutlet weak var quickhelpLabel: UILabel!
    @IBOutlet weak var quickHelpCollectionView: UICollectionView!
    @IBOutlet weak var needMoreHelpLabel: UILabel!
    @IBOutlet weak var needMoreHelpTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var yourSatisfactionLabel: UILabel!
    @IBOutlet weak var weAreCommittedToProvideLabel: UILabel!
    
    let quickHelpItems = [
        QuickHelpItem(title: "FAQs", description: "Find answers to common questions"),
        QuickHelpItem(title: "User Guide", description: "Learn how to use the app effectively"),
        QuickHelpItem(title: "Billing & Payments", description: "Help with payments, refunds and invoices"),
        QuickHelpItem(title: "Charging Help", description: "Issues with charging stations or sessions")
    ]
    
    let needHelpItems = [
        QuickHelpItem(title: "Contact Support", description: "Talk to our support team"),
        QuickHelpItem(title: "Report an Issue", description: "Report a problem or give feedback"),
        QuickHelpItem(title: "Station Issue", description: "Report a problem with a charging station"),
        QuickHelpItem(title: "Payment Issue", description: "Need help with a payment"),
        QuickHelpItem(title: "Offers & Promotions", description: "Help with offers and promocodes")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quickHelpCollectionView.register(UINib(nibName: "QuickHelpCVC", bundle: nil), forCellWithReuseIdentifier: "QuickHelpCVC")
        if let layout = quickHelpCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        needMoreHelpTableView.register(UINib(nibName: "NeedMoreHelpTVC", bundle: nil), forCellReuseIdentifier: "NeedMoreHelpTVC")
        
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func liveChatButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "LiveChartVC") as! LiveChartVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    
}

extension SupportAndHelpVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quickHelpItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickHelpCVC", for: indexPath) as! QuickHelpCVC
        let quickHelp = quickHelpItems[indexPath.row]
        cell.configure(model: quickHelp)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 5
        let totalSpacing = spacing * 2
        let availableWidth = collectionView.frame.width - totalSpacing
        let itemWidth = availableWidth / 2
        let itemHeight: CGFloat = 77
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension SupportAndHelpVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return needHelpItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeedMoreHelpTVC") as! NeedMoreHelpTVC
        let needHelp = needHelpItems[indexPath.row]
        cell.configure(model: needHelp, isFirstRow: indexPath.row == 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

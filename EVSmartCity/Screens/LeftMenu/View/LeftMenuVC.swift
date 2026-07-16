//
//  LeftMenuVC.swift
//  EVSmartCity
//
//  Created by Hitman on 15/05/26.

import UIKit

class LeftMenuVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var leftMenuTableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var platinumMemberLabel: UILabel!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var primaryEvLabel: UILabel!
    @IBOutlet weak var manageButton: UIButton!
    
    var menuData: [[SideMenuModel]] = []
    var selectedIndexPath: IndexPath?
    
    private let selectedLanguageKey = "SelectedLanguageIndex"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuData()
        setupTableView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backView.applyShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMenuData()
        leftMenuTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.applyGreenGradient()
    }
    
    private func getSelectedLanguage() -> String {
        let languages = ["English","العربية","हिन्दी","ಕನ್ನಡ","தமிழ்","తెలుగు"]
        let selectedIndex = UserDefaults.standard.integer(
            forKey: selectedLanguageKey
        )
        return selectedIndex < languages.count ? languages[selectedIndex] : "English"
    }
    
    func setupMenuData() {
        menuData = [
            [
                SideMenuModel(image: "house.fill", title: "Home", description: "Analytics & Insights"),
                SideMenuModel(image: "clock.arrow.circlepath", title: "Charging History", description: "Sessions, Cost, Duration"),
                SideMenuModel(image: "bolt.circle.fill", title: "Active Charging", description: "Live charging session"),
                SideMenuModel(image: "wallet.bifold", title: "Payment & Wallet", description: "Payments, refunds...")
            ],
            [
                SideMenuModel(image: "sun.max", title: "Appearance", description: "System", isPreference: true),
                SideMenuModel(image: "globe.central.south.asia",title: "Language",description: getSelectedLanguage(),isPreference: true)
            ],
            [
                SideMenuModel(image: "shield.pattern.checkered", title: "Security & Privacy", description: "MFA, trusted devices"),
                SideMenuModel(image: "gearshape", title: "Settings", description: "App preferences"),
                SideMenuModel(image: "headset", title: "Support & Help", description: "24/7 English")
            ],
        ]
    }
    
    func setupTableView() {
        leftMenuTableView.register(UINib(nibName: "LeftMenuTVC", bundle: nil), forCellReuseIdentifier: "LeftMenuTVC")
        leftMenuTableView.register(UINib(nibName: "PreferenceItemTVC", bundle: nil), forCellReuseIdentifier: "PreferenceItemTVC")
        leftMenuTableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderView.identifier)
        
        leftMenuTableView.showsVerticalScrollIndicator = false
        leftMenuTableView.separatorStyle = .none
        leftMenuTableView.backgroundColor = .white
        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
    }

    @IBAction func dismissButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignOutVC") as! SignOutVC
            if let sheet = vc.sheetPresentationController {
                let customDetent = UISheetPresentationController.Detent.custom { context in
                    return context.maximumDetentValue * 0.50
                }
                sheet.detents = [customDetent]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            present(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignOutVC") as! SignOutVC
            if let sheet = vc.sheetPresentationController {
                let customDetent = UISheetPresentationController.Detent.custom { context in
                    return context.maximumDetentValue * 0.30
                }
                sheet.detents = [customDetent]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            present(vc, animated: true)
        }
    }
    
    @IBAction func manageButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Vehicle", bundle: nil).instantiateViewController(withIdentifier: "VehicleManageVC") as! VehicleManageVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true, completion: nil)
    }
    
}

extension LeftMenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menuData[indexPath.section][indexPath.row]
        let isSelected = (selectedIndexPath == indexPath)
        
        if item.isPreference == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceItemTVC") as! PreferenceItemTVC
            cell.configure(image: item.image, title: item.title, description: item.description, isSelected: isSelected)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTVC") as! LeftMenuTVC
        cell.configure(model: item, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            switch row {
            case 0: navigateToHome()
            case 1: navigateToChargingHistory()
            case 2: navigateToActiveCharging()
            case 3: navigateToPayments()
            default: break
            }
            
        case 1:
            switch row {
            case 0: navigateToAppearance()
            case 1: navigateToLanguage()
            default: break
            }
            
        case 2:
            switch row {
            case 0: navigateToSecurity()
            case 1: navigateToSettings()
            case 2: navigateToSupport()
            default: break
            }
            
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.identifier) as? SettingsHeaderView
            header?.configure(title: "PREFERENCES")
            return header
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }

        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == menuData.count - 1 {
            return 0
        }
        return 12
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let containerView = UIView()
        containerView.backgroundColor = .white

        let lineView = UIView(frame: CGRect(x: 20,y: 20,width: tableView.frame.width - 40,height: 0.5))
        lineView.backgroundColor = UIColor.systemGray2

        containerView.addSubview(lineView)

        return containerView
    }
        
    private func navigateToHome() {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AnalyticsAndInsightsVC") as! AnalyticsAndInsightsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    private func navigateToChargingHistory() {
        print("Tapped Charging History")
    }
    
    private func navigateToActiveCharging() {
        print("Tapped Active Charging")
    }
    
    private func navigateToPayments() {
        print("Tapped Payment & Wallet")
    }
    
    private func navigateToAppearance() {
        print("Tapped Appearance")
    }
    
    private func navigateToLanguage() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LanguagesVC") as! LanguagesVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func navigateToSecurity() {
        print("Tapped Security & Privacy")
    }
    
    private func navigateToSettings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func navigateToSupport() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SupportAndHelpVC") as! SupportAndHelpVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}



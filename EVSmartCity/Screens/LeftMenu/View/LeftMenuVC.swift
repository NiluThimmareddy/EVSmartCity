//
//  LeftMenuVC.swift
//  EVSmartCity
//
//  Created by Hitman on 15/05/26.
//

import UIKit

class LeftMenuVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var whiteModeButton: UIButton!
    @IBOutlet weak var darkModeButton: UIButton!
    @IBOutlet weak var engLanguageButton: UIButton!
    @IBOutlet weak var arabicLanguageButton: UIButton!
    @IBOutlet weak var leftMenuTableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    let mainMenuArray: [[SideMenuModel]] = [[
        SideMenuModel(image: "house",title: "Home",description: "Dashboard overview"),
        SideMenuModel(image: "location.circle",title: "Find Stations",description: "5 chargers near you"),
        SideMenuModel(image: "clock.arrow.circlepath",title: "Charging History",description: "Sessions, cost, duration"),
        SideMenuModel(image: "car",title: "My Car",description: "Battery, tyres, health"),
        SideMenuModel(image: "map",title: "Plan a Trip",description: "Route with charging stops")
    ],
                                            
    [
      SideMenuModel(image: "creditcard",title: "Payments",description: "SAR 248.50 balance"),
      SideMenuModel(image: "gearshape",title: "Settings",description: "Language, notifications"),
      SideMenuModel(image: "questionmark.circle",title: "Support & Help",description: "24/7 English"),
      SideMenuModel(image: "exclamationmark.triangle",title: "Report an Issue",description: "Broken charger, billing")
    ]
    ]
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        backView.applyShadow()
    }
    
    func setupTableView() {
        leftMenuTableView.register(UINib(nibName: "LeftMenuTVC", bundle: nil), forCellReuseIdentifier: "LeftMenuTVC")
        leftMenuTableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderView.identifier)
        leftMenuTableView.showsVerticalScrollIndicator = false
    }

    @IBAction func dismissButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func whiteModeButtonAction(_ sender: Any) {
    }
    
    @IBAction func darkModeButtonAction(_ sender: Any) {
    }
    
    @IBAction func englishLanguageButtonAction(_ sender: Any) {
    }
    
    @IBAction func arabicLanguageButtonAction(_ sender: Any) {
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
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

extension LeftMenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTVC") as! LeftMenuTVC
        let item = mainMenuArray[indexPath.section][indexPath.row]
        let isSelected = (selectedIndexPath == indexPath)
        let isFindStationsRow = (indexPath.section == 0 && indexPath.row == 1)
        var stationCount: String? = nil
        if isFindStationsRow {
            let description = item.description
            let numberString = description.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            stationCount = numberString.isEmpty ? nil : numberString
        }
        cell.configure(model: item, isSelected: isSelected, showStationCount: isFindStationsRow, stationCount: stationCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        let selectedItem = mainMenuArray[indexPath.section][indexPath.row]
        
        let menuItem = "\(indexPath.section)-\(indexPath.row)"
        switch menuItem {
        case "0-0":
            navigateToHome()
        case "0-1":
            navigateToFindStations()
        case "0-2":
            navigateToChargingHistory()
        case "0-3":
            navigateToMyCar()
        case "0-4":
            navigateToPlanTrip()
            
        case "1-0":
            navigateToPayments()
        case "1-1":
            navigateToSettings()
        case "1-2":
            navigateToSupport()
        case "1-3":
            navigateToReportIssue()
            
        default:
            break
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.identifier) as? SettingsHeaderView
        
        let sectionType = SettingsSection(rawValue: section)
        switch sectionType {
        case .securityPrivacy:
            header?.configure(title: "Main")
        case .aboutApp:
            header?.configure(title: "Account")
        default:
            break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    private func navigateToHome() {
        print("Tapped Home")
    }

    private func navigateToFindStations() {
        print("Tapped FindStations")
    }

    private func navigateToChargingHistory() {
        print("Tapped Charging History")
    }

    private func navigateToMyCar() {
        print("Tapped Car")
    }

    private func navigateToPlanTrip() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "PlanTripViewController") as! PlanTripViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }

    private func navigateToPayments() {
        print("Tapped Payment")
    }

    private func navigateToSettings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SettingsVC") as! SettingsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }

    private func navigateToSupport() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SupportAndHelpVC") as! SupportAndHelpVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }

    private func navigateToReportIssue() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "ReportAnIssueVC") as! ReportAnIssueVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

//
//  SettingsViewController.swift
//  EVSmartCity
//
//  Created by Hitman on 13/07/26.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsTitlelabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var goldMemberButton: UIButton!
    @IBOutlet weak var preferencesLabel: UILabel!
    @IBOutlet weak var preferencesView: UIView!
    @IBOutlet weak var languageTitleLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var appearanceTitleLabel: UILabel!
    @IBOutlet weak var appearanceSegmentControl: UISegmentedControl!
    @IBOutlet weak var defaultMapViewLabel: UILabel!
    @IBOutlet weak var mapbutton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var defaultSortOrderLabel: UILabel!
    @IBOutlet weak var sortOrderButton: UIButton!
    @IBOutlet weak var defaultChargeStopTargetLabel: UILabel!
    @IBOutlet weak var socLabel: UILabel!
    @IBOutlet weak var socPercentLabel: UILabel!
    @IBOutlet weak var energyTitleLabel: UILabel!
    @IBOutlet weak var energyConsumedValueLabel: UILabel!
    @IBOutlet weak var costTitleLabel: UILabel!
    @IBOutlet weak var costSARLabel: UILabel!
    @IBOutlet weak var unitsTitleLabel: UILabel!
    @IBOutlet weak var metricsLabel: UILabel!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var unitsView: UIView!
    @IBOutlet weak var appSettingsTitleLabel: UILabel!
    @IBOutlet weak var appSettingsTableView: UITableView!
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    
    let settingsItems: [SettingItem] = [
        SettingItem(title: "Notification Preferences",subtitle: "Alerts, charging updates",iconName: "tag"),
        SettingItem(title: "Security & Privacy",subtitle: "2FA, data permissions",iconName: "lock"),
        SettingItem(title: "Manage Vehicles",subtitle: "Add or remove cars",iconName: "car.rear"),
        SettingItem(title: "Payment Methods",subtitle: "Default card: Visa •••• 4242",iconName: "creditcard"),
        SettingItem(title: "Terms & Privacy Policy",subtitle: "Legal documentation",iconName: "text.document"),
        SettingItem(title: "Contact Support",subtitle: "24/7 help center",iconName: "headset"),
        SettingItem(title: "Rate This App",subtitle: "Share your feedback",iconName: "star")
    ]
    
    private let selectedSortKey = "SelectedSortIndex"
    private let selectedLanguageKey = "SelectedLanguageIndex"
    private let appearanceKey = "SelectedAppearance"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func appearanceSegmentAction(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: appearanceKey)
        applyAppearance(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func languageButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguagesVC") as! LanguagesVC
        vc.delegate = self
        vc.selectedIndex = UserDefaults.standard.integer(forKey: selectedLanguageKey)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func mapButtonAction(_ sender: Any) {
    }
   
    @IBAction func listButtonAction(_ sender: Any) {
    }
    
    @IBAction func sortOrderButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SortOrderVC") as! SortOrderVC
        vc.delegate = self
        vc.selectedIndex = UserDefaults.standard.integer(forKey: selectedSortKey)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
    }
    
}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        let settings = settingsItems[indexPath.row]
        cell.configure(with: settings)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}

extension SettingsViewController: SortOrderVCDelegate {
    func didSelectSortOption(_ option: SortOption, selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: selectedSortKey)
        var config = sortOrderButton.configuration
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        config?.attributedTitle = AttributedString(option.title,attributes: attributes)
        sortOrderButton.configuration = config
    }
}

extension SettingsViewController: LanguagesVCDelegate {
    func didSelectLanguage(_ language: LanguageModel,selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex,forKey: selectedLanguageKey)
        var config = languageButton.configuration
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        attributes.foregroundColor = UIColor(hex: "#575757")
        config?.attributedTitle = AttributedString(language.nativeName,attributes: attributes)
        languageButton.configuration = config
    }
}

extension SettingsViewController {
    func setUpUI() {
        
        let selectedIndex = UserDefaults.standard.integer(forKey: selectedSortKey)
        let titles = ["Distance", "Price", "Reliability", "AI Recommended"]
        if selectedIndex < titles.count {
            var config = sortOrderButton.configuration
            var attributes = AttributeContainer()
            attributes.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            config?.attributedTitle = AttributedString(titles[selectedIndex],attributes: attributes)
            sortOrderButton.configuration = config
        }
        
        let languageIndex = UserDefaults.standard.integer(forKey: selectedLanguageKey)
        let languages = ["English","العربية","हिन्दी","ಕನ್ನಡ","தமிழ்","తెలుగు"]
        if languageIndex < languages.count {
            var config = languageButton.configuration
            var attributes = AttributeContainer()
            attributes.font = UIFont.systemFont(ofSize: 16,weight: .regular)
            attributes.foregroundColor = UIColor(hex: "#575757")
            config?.attributedTitle = AttributedString(languages[languageIndex],attributes: attributes)
            languageButton.configuration = config
        }
        

        let savedIndex = UserDefaults.standard.integer(forKey: appearanceKey)
        appearanceSegmentControl.selectedSegmentIndex = savedIndex
        applyAppearance(index: savedIndex)
        
        profileView.applyLightShadow()
        preferencesView.applyLightShadow()
        appSettingsTableView.applyLightShadow()
        
        languageView.layer.cornerRadius = 30
        languageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        languageView.layer.masksToBounds = true
        
        unitsView.layer.cornerRadius = 30
        unitsView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        unitsView.layer.masksToBounds = true
        
        goldMemberButton.applyGoldMemberGradient()
        
        appSettingsTableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    func applyAppearance(index: Int) {
        guard let window = view.window ?? UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap({ $0.windows }).first(where: { $0.isKeyWindow }) else {
            return
        }
        switch index {
        case 0:
            window.overrideUserInterfaceStyle = .unspecified
        case 1:
            window.overrideUserInterfaceStyle = .light
        case 2:
            window.overrideUserInterfaceStyle = .dark
        default:
            break
        }
    }
}

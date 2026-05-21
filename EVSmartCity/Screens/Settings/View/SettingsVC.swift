//
//  SettingsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 13/05/26.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsTitleLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    let settingsData: [[SettingsItem]] = [
        // Section 0: Security & Privacy
        [ SettingsItem(type: .biometric,title: "Biometric Login",description: "Use Face ID / Fingerprint",iconName: "faceid",
                       hasSwitch: true,hasBadge: false,hasButton: false,badgeText: nil),
          SettingsItem(type: .changePasscode,title: "Change Passcode",description: "Update your app passcode",iconName: "lock",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil),
          SettingsItem(type: .deviceManagement,title: "Device Management",description: "Manage logged-in devices",iconName: "devices",hasSwitch: false,hasBadge: true,hasButton: false,badgeText: "1 active"),
          SettingsItem(type: .permissions,title: "Permissions",description: "Location, Notifications",iconName: "permission",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil)
        ],
        
        // Section 1: About App
        [ SettingsItem(type: .appVersion,title: "App Version",description: "You are using the latest version",iconName: "version",hasSwitch: false,hasBadge: false,hasButton: true,badgeText: "v2.1.0"),
            SettingsItem(type: .termsConditions,title: "Terms & Conditions",description: "Read our terms and conditions",
                iconName: "terms",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil),
            SettingsItem(type: .privacyPolicy,title: "Privacy Policy",description: "Read our privacy policy",iconName: "privacy",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil),
            SettingsItem(type: .rateApp,title: "Rate App",description: "Rate us on App Store",iconName: "star",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil),
            SettingsItem(type: .shareApp,title: "Share App",description: "Share EV Saudi with your friends",iconName: "share",hasSwitch: false,hasBadge: false,hasButton: false,badgeText: nil)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        settingsTableView.register(UINib(nibName: "SettingsTVC", bundle: nil), forCellReuseIdentifier: "SettingsTVC")
        settingsTableView.separatorStyle = .singleLine
        settingsTableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderView.identifier)
        settingsTableView.showsVerticalScrollIndicator = false
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTVC") as! SettingsTVC
        let item = settingsData[indexPath.section][indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.identifier) as? SettingsHeaderView
        
        let sectionType = SettingsSection(rawValue: section)
        switch sectionType {
        case .securityPrivacy:
            header?.configure(title: "Security & Privacy", iconName: "checkmark.shield")
        case .aboutApp:
            header?.configure(title: "About App", iconName: "info.circle.fill")
        default:
            break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = settingsData[indexPath.section][indexPath.row]
        
        switch item.type {
        case .biometric:
            handleBiometric()
        case .changePasscode:
            handleChangePasscode()
        case .deviceManagement:
            handleDeviceManagement()
        case .permissions:
            handlePermissions()
        case .appVersion:
            handleVersion()
        case .termsConditions:
            handleTermsConditions()
        case .privacyPolicy:
            handlePrivacyPolicy()
        case .rateApp:
            handleRateApp()
        case .shareApp:
            handleShareApp()
        default:
            break
        }
    }
    
    // MARK: - Actions
    
    func handleBiometric() {
        let storyboard = UIStoryboard(name: "Biometric", bundle: nil).instantiateViewController(withIdentifier: "BiometricLoginVC") as! BiometricLoginVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    func handleChangePasscode() {
        let storyboard = UIStoryboard(name: "Biometric", bundle: nil).instantiateViewController(withIdentifier: "ChangePasscodeVC") as! ChangePasscodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    func handleDeviceManagement() {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "DeviceManagementVC") as! DeviceManagementVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    func handlePermissions() {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "PermissionsVC") as! PermissionsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    func handleVersion() {
        print("Open About version")
    }
    func handleTermsConditions() {

        print("Open Terms&Conditions")
    }
    
    func handlePrivacyPolicy() {
        print("Open Privacy Policy")
    }
    
    func handleRateApp() {
//        if let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") {
//            UIApplication.shared.open(url)
//        }
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "RateAppVC") as! RateAppVC
        storyboard.modalPresentationStyle = .overFullScreen
        present(storyboard, animated: true)
    }
    
    func handleShareApp() {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ShareAppVC") as! ShareAppVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

extension SettingsVC: SettingsTVCDelegate {
    func biometricSwitchChanged(isOn: Bool) {
        print("Biometric login switched: \(isOn)")
        UserDefaults.standard.set(isOn, forKey: "biometricLoginEnabled")
    }
    
    func versionButtonTapped() {
        print("Version button tapped")
        let alert = UIAlertController(title: "App Version", message: "You are using version 2.1.0", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


// Custom Header Class
class SettingsHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "SettingsHeaderView"
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.tintColor = UIColor(hex: "#379D67")
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(title: String, iconName: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: iconName)
    }
    func configure(title: String){
        titleLabel.text = title
    }
}

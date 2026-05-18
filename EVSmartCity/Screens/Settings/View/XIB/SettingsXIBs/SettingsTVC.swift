//
//  SettingsTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 14/05/26.

import UIKit

protocol SettingsTVCDelegate: AnyObject {
    func biometricSwitchChanged(isOn: Bool)
    func versionButtonTapped()
}

class SettingsTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var settingImgViews: UIImageView!
    @IBOutlet weak var settingTitleLabel: UILabel!
    @IBOutlet weak var settingDescriptionLabel: UILabel!
    @IBOutlet weak var biometricSwitch: UISwitch!
    @IBOutlet weak var activeDevicesLabel: UILabel!
    @IBOutlet weak var versionButton: UIButton!
    
    weak var delegate: SettingsTVCDelegate?
    private var currentItemType: CellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    func setupUI() {
        biometricSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        versionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configure(with item: SettingsItem) {
        currentItemType = item.type
        
        settingTitleLabel.text = item.title
        settingDescriptionLabel.text = item.description
        settingImgViews.image = UIImage(systemName: iconNameForType(item.type))
        
        // Show/hide elements based on item type
        biometricSwitch.isHidden = !item.hasSwitch
        activeDevicesLabel.isHidden = !item.hasBadge
        versionButton.isHidden = !item.hasButton
        
        // Set badge text
        if item.hasBadge {
            activeDevicesLabel.text = item.badgeText
        }
        
        // Set button title
        if item.hasButton {
            versionButton.setTitle(item.badgeText, for: .normal)
        }
        
        // Load saved switch state for biometric
        if item.type == .biometric {
            let isEnabled = UserDefaults.standard.bool(forKey: "biometricLoginEnabled")
            biometricSwitch.isOn = isEnabled
        }
        
        // Add accessory indicator for tappable cells
        if item.type != .biometric && item.type != .appVersion {
            accessoryType = .disclosureIndicator
        } else {
            accessoryType = .none
        }
    }
    
    func iconNameForType(_ type: CellType) -> String {
        switch type {
        case .biometric:
            return "touchid"
        case .changePasscode:
            return "lock"
        case .deviceManagement:
            return "desktopcomputer"
        case .permissions:
            return "hand.raised"
        case .appVersion:
            return "info.circle"
        case .termsConditions:
            return "doc.text"
        case .privacyPolicy:
            return "checkmark.shield"
        case .rateApp:
            return "star"
        case .shareApp:
            return "square.and.arrow.up"
        }
    }
    
    func resetUI() {
        biometricSwitch.isHidden = true
        activeDevicesLabel.isHidden = true
        versionButton.isHidden = true
        accessoryType = .none
        settingImgViews.image = nil
        settingTitleLabel.text = nil
        settingDescriptionLabel.text = nil
    }
    
    @objc func switchValueChanged() {
        delegate?.biometricSwitchChanged(isOn: biometricSwitch.isOn)
    }
    
    @objc func buttonTapped() {
        delegate?.versionButtonTapped()
    }
    
    @IBAction func biometricSwitchAction(_ sender: Any) {
    }
    
    @IBAction func versionButtonAction(_ sender: Any) {
    }
}

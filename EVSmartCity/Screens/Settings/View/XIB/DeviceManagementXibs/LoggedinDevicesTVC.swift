//
//  LoggedinDevicesTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 12/05/26.

import UIKit

protocol LoggedinDevicesTVCDelegate: AnyObject {
    func didTapDeleteButton(for device: LoggedInDevice, at index: Int)
}

class LoggedinDevicesTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deviceImgView: UIImageView!
    @IBOutlet weak var thisDeviceButton: UIButton!
    @IBOutlet weak var deleteDeviceButton: UIButton!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var osAndLocationLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var deviceNameTopConstraint: NSLayoutConstraint!
    
    weak var delegate: LoggedinDevicesTVCDelegate?
    weak var parentViewController: UIViewController?
    private var currentDevice: LoggedInDevice?
    private var currentIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deviceNameLabel.numberOfLines = 0
        osAndLocationLabel.numberOfLines = 0
        activeLabel.numberOfLines = 1
        deviceNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        osAndLocationLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        // Style delete button
        deleteDeviceButton.tintColor = .systemRed
    }

    @IBAction func deleteDeviceButtonAction(_ sender: Any) {
        guard let device = currentDevice else { return }
        
        let alert = UIAlertController(
            title: "Remove Device",
            message: "Are you sure you want to remove \(device.deviceName)? You will be logged out from this device.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didTapDeleteButton(for: device, at: self.currentIndex)
        })
        
        if let parentVC = parentViewController {
            parentVC.present(alert, animated: true)
        } else if let viewController = findViewController() {
            viewController.present(alert, animated: true)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
    
    func configure(device: LoggedInDevice, at index: Int, delegate: LoggedinDevicesTVCDelegate?, parentVC: UIViewController?) {
        self.currentDevice = device
        self.currentIndex = index
        self.delegate = delegate
        self.parentViewController = parentVC
        
        deviceImgView.image = UIImage(systemName: device.deviceImage)
        deviceImgView.tintColor = UIColor(hex: "#379D67")
        
        deviceNameLabel.text = device.deviceName
        osAndLocationLabel.text = "\(device.os) • \(device.location)"
        
        if device.isCurrentDevice {
            activeLabel.text = "Active now"
            activeLabel.textColor = UIColor(hex: "#379D67")
            thisDeviceButton.isHidden = false
            thisDeviceButton.setTitle("This device", for: .normal)
            thisDeviceButton.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            thisDeviceButton.setTitleColor(UIColor(hex: "#379D67"), for: .normal)
            deviceNameTopConstraint.constant = 10
            
            // ALLOW DELETE FOR ACTIVE DEVICE - Enable delete button
            deleteDeviceButton.isEnabled = true
            deleteDeviceButton.tintColor = .systemRed
        } else {
            activeLabel.text = device.lastActive
            activeLabel.textColor = .secondaryLabel
            thisDeviceButton.isHidden = true
            deviceNameTopConstraint.constant = -20
            
            deleteDeviceButton.isEnabled = true
            deleteDeviceButton.tintColor = .systemRed
        }
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deviceImgView.image = nil
        deviceNameLabel.text = nil
        osAndLocationLabel.text = nil
        activeLabel.text = nil
        thisDeviceButton.isHidden = false
        deleteDeviceButton.isEnabled = true
        deleteDeviceButton.tintColor = .systemRed
        deviceNameTopConstraint.constant = 10
        currentDevice = nil
        delegate = nil
        parentViewController = nil
    }
}

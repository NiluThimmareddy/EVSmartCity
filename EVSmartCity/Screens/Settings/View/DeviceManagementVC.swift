//
//  DeviceManagementVC.swift
//  EVSmartCity
//
//  Created by Hitman on 12/05/26.

import UIKit

class DeviceManagementVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deviceManagementLabel: UILabel!
    @IBOutlet weak var keepYourAccountSecureLabel: UILabel!
    @IBOutlet weak var reviewTheDeviceLabel: UILabel!
    @IBOutlet weak var loggedView: UIView!
    @IBOutlet weak var loggedInDevicesLabel: UILabel!
    @IBOutlet weak var loggedDeviceCountLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var loggedDevicesTableView: UITableView!
    @IBOutlet weak var loggedInViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var didNotRecognizeTableView: UITableView!
    @IBOutlet weak var logOutFromAllDevicesTableView: UITableView!
    
    var devices = [
        LoggedInDevice(deviceName: "iPhone 17 Pro", os: "iOS 26.4", location: "New York, USA", lastActive: "Active now", isCurrentDevice: true, deviceImage: "iphone"),
        LoggedInDevice(deviceName: "MacBook Air", os: "macOS Sonoma 14.2", location: "New York, USA", lastActive: "Yesterday, 10:30 AM", isCurrentDevice: false, deviceImage: "macbook"),
        LoggedInDevice(deviceName: "Samsung Galaxy S23", os: "Android 14", location: "Chicago, USA", lastActive: "Mar 20, 2024 at 8:15 PM", isCurrentDevice: false, deviceImage: "iphone"),
        LoggedInDevice(deviceName: "iPad Mini", os: "iPadOS 17.3", location: "Miami, USA", lastActive: "Mar 19, 2024 at 2:20 PM", isCurrentDevice: false, deviceImage: "ipad"),
        LoggedInDevice(deviceName: "Dell XPS 15", os: "Windows 11", location: "Denver, USA", lastActive: "Mar 17, 2024 at 10:00 AM", isCurrentDevice: false, deviceImage: "desktopcomputer")
    ]

    let tableViewTopBottomPadding: CGFloat = 50
    let minimumTableViewHeight: CGFloat = 50
    
    var response: LoggedInDevicesResponse {
        return LoggedInDevicesResponse(totalCount: devices.count, devices: devices)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func refereshButtonAction(_ sender: Any) {
        performRefreshWithAnimation()
    }
    
    func deleteAllDevices() {
        guard !devices.isEmpty else {
            showToast(message: "No devices to logout")
            return
        }
        
        let alert = UIAlertController(
            title: "Logout All Devices",
            message: "Are you sure you want to logout from ALL \(devices.count) devices? You will be logged out from your current device as well.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout All", style: .destructive) { [weak self] _ in
            self?.performDeleteAllDevices()
        })
        present(alert, animated: true)
    }
    
    private func performDeleteAllDevices() {
        devices.removeAll()
        loggedDevicesTableView.reloadData()
        updateDeviceCountLabel()
        updateTableViewHeight()
        showEmptyStateIfNeeded()
        showToast(message: "Successfully logged out from all devices")
    }
    
    func logoutAllInactiveDevices() {
        let inactiveDevices = devices.filter { !$0.isCurrentDevice }
        guard !inactiveDevices.isEmpty else {
            showToast(message: "No inactive devices to logout")
            return
        }
        
        let alert = UIAlertController(
            title: "Logout All Devices",
            message: "Are you sure you want to logout from all \(inactiveDevices.count) inactive device(s)? You will remain logged in on your current device.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout All", style: .destructive) { [weak self] _ in
            self?.performLogoutAllInactive()
        })
        present(alert, animated: true)
    }
    
    private func performLogoutAllInactive() {
        let currentDevice = devices.filter { $0.isCurrentDevice }
        devices = currentDevice
        
        loggedDevicesTableView.reloadData()
        
        updateDeviceCountLabel()
        updateTableViewHeight()
        
        showEmptyStateIfNeeded()
        showToast(message: "Successfully logged out from all inactive devices")
    }
    
    func showEmptyStateIfNeeded() {
        if devices.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "No devices logged in"
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .gray
            emptyLabel.font = UIFont.systemFont(ofSize: 16)
            emptyLabel.frame = CGRect(x: 0, y: 0, width: loggedDevicesTableView.bounds.width, height: 200)
            loggedDevicesTableView.backgroundView = emptyLabel
            loggedDevicesTableView.separatorStyle = .none
        } else {
            loggedDevicesTableView.backgroundView = nil
            loggedDevicesTableView.separatorStyle = .singleLine
        }
    }
}

extension DeviceManagementVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == loggedDevicesTableView {
            return devices.count
        } else if tableView == didNotRecognizeTableView {
            return 1
        } else if tableView == logOutFromAllDevicesTableView {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == loggedDevicesTableView {
            if devices.isEmpty {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoggedinDevicesTVC") as! LoggedinDevicesTVC
            let device = devices[indexPath.row]
            cell.configure(device: device, at: indexPath.row, delegate: self, parentVC: self)
            cell.layoutIfNeeded()
            return cell
        } else if tableView == didNotRecognizeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonotRecognizeDeviceTVC") as! DonotRecognizeDeviceTVC
            return cell
        } else if tableView == logOutFromAllDevicesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogOutFromAllDevicesTVC") as! LogOutFromAllDevicesTVC
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DonotRecognizeDeviceTVC") as! DonotRecognizeDeviceTVC
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == logOutFromAllDevicesTableView {
            tableView.deselectRow(at: indexPath, animated: true)
            deleteAllDevices()
        } else if tableView == didNotRecognizeTableView {
            let storyboard = storyboard?.instantiateViewController(withIdentifier: "DonotRecognizeDeviceVC") as! DonotRecognizeDeviceVC
            storyboard.modalPresentationStyle = .fullScreen
            present(storyboard, animated: true)
        }
    }
}

extension DeviceManagementVC: LoggedinDevicesTVCDelegate {
    func didTapDeleteButton(for device: LoggedInDevice, at index: Int) {
        devices.remove(at: index)
        loggedDevicesTableView.performBatchUpdates({
            loggedDevicesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }, completion: { _ in
            self.updateDeviceCountLabel()
            self.updateTableViewHeight()
            self.loggedDevicesTableView.reloadData()
            self.showEmptyStateIfNeeded()
        })
        showToast(message: "\(device.deviceName) removed successfully")
        
//        if device.isCurrentDevice {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                self.dismiss(animated: true)
//            }
//        }
    }
    
}

extension DeviceManagementVC {
    func setUpUI() {
        loggedDevicesTableView.register(UINib(nibName: "LoggedinDevicesTVC", bundle: nil), forCellReuseIdentifier: "LoggedinDevicesTVC")
        loggedDevicesTableView.isScrollEnabled = false
        loggedDevicesTableView.rowHeight = UITableView.automaticDimension
        loggedDevicesTableView.estimatedRowHeight = 120
        loggedDevicesTableView.reloadData()
        
        didNotRecognizeTableView.register(UINib(nibName: "DonotRecognizeDeviceTVC", bundle: nil), forCellReuseIdentifier: "DonotRecognizeDeviceTVC")
        didNotRecognizeTableView.isScrollEnabled = false
        didNotRecognizeTableView.rowHeight = UITableView.automaticDimension
        didNotRecognizeTableView.estimatedRowHeight = 120
        
        logOutFromAllDevicesTableView.register(UINib(nibName: "LogOutFromAllDevicesTVC", bundle: nil), forCellReuseIdentifier: "LogOutFromAllDevicesTVC")
        logOutFromAllDevicesTableView.isScrollEnabled = false
        logOutFromAllDevicesTableView.rowHeight = UITableView.automaticDimension
        logOutFromAllDevicesTableView.estimatedRowHeight = 100
        
        updateDeviceCountLabel()
        updateTableViewHeight()
    }
    
    func updateDeviceCountLabel() {
        loggedDeviceCountLabel.text = "\(devices.count)"
        loggedDeviceCountLabel.clipsToBounds = true
        
        if devices.isEmpty {
            loggedDeviceCountLabel.textColor = .systemRed
            loggedDeviceCountLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        } else {
            loggedDeviceCountLabel.textColor = UIColor(hex: "#379D67")
            loggedDeviceCountLabel.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
        }
    }
    
    func updateTableViewHeight() {
        loggedDevicesTableView.reloadData()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let contentHeight = self.loggedDevicesTableView.contentSize.height
            let finalHeight = max(contentHeight, self.minimumTableViewHeight)
            self.loggedInViewHeightConstraint.constant = finalHeight + self.tableViewTopBottomPadding
            self.view.layoutIfNeeded()
        }
    }
    
    func rotateRefreshButton(duration: CFTimeInterval = 0.6, completion: (() -> Void)? = nil) {
        refreshButton.isUserInteractionEnabled = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = duration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        refreshButton.imageView?.layer.add(rotationAnimation, forKey: "rotateAnimation")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.refreshButton.imageView?.layer.removeAnimation(forKey: "rotateAnimation")
            self?.refreshButton.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    func rotateRefreshButtonWithMultipleRotations(duration: CFTimeInterval = 2.0, completion: (() -> Void)? = nil) {
        refreshButton.isUserInteractionEnabled = false
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2 * 3
        rotationAnimation.duration = duration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        refreshButton.imageView?.layer.add(rotationAnimation, forKey: "rotateAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.refreshButton.imageView?.layer.removeAnimation(forKey: "rotateAnimation")
            self?.refreshButton.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    func performRefreshWithAnimation() {
        rotateRefreshButtonWithMultipleRotations(duration: 2.0) { [weak self] in
            self?.refreshData()
        }
    }
    
    func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.updateTableViewHeight()
            self.updateDeviceCountLabel()
            self.loggedDevicesTableView.reloadData()
            self.showEmptyStateIfNeeded()
        }
    }
}

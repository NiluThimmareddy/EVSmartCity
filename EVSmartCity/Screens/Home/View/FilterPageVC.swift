//
//  FilterPageVC.swift
//  EVSmartCity
//
//  Created by Hitman on 06/05/26.

import UIKit

class FilterPageVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var availableChargersOnly: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var chargingBasicsLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var dcButton: UIButton!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var ConnectorTypeCollectionView: UICollectionView!
    @IBOutlet weak var chargingSpeedLabel: UILabel!
    @IBOutlet weak var chargingRangeslider: RangeSeekSlider!
    @IBOutlet weak var accessTypesLabel: UILabel!
    @IBOutlet weak var commericalButton: UIButton!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var privateButton: UIButton!
    @IBOutlet weak var clearFliterButton: UIButton!
    @IBOutlet weak var applyFilterbuttonAction: UIButton!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var connector = [
        ConnectorType(connector: "CCS2"),
        ConnectorType(connector: "AC001"),
        ConnectorType(connector: "CCS2"),
        ConnectorType(connector: "Type-2"),
        ConnectorType(connector: "Domestic"),
        ConnectorType(connector: "TESLA_R"),
        ConnectorType(connector: "TESLA_S")
    ]
    
    var selectedConnectors: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupButtons()
        setupRangeSlider()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    func setupRangeSlider() {
        chargingRangeslider.minValue = 0
        chargingRangeslider.maxValue = 500
        chargingRangeslider.selectedMinValue = 0
        chargingRangeslider.selectedMaxValue = 500
        chargingRangeslider.minDistance = 10
        chargingRangeslider.handleColor = UIColor(hex: "379D67")
        chargingRangeslider.handleBorderColor = UIColor(hex: "379D67")
        chargingRangeslider.colorBetweenHandles = UIColor(hex: "379D67")
        chargingRangeslider.tintColor = UIColor.lightGray
    }
    
    func setupCollectionView() {
        ConnectorTypeCollectionView.register(UINib(nibName: "ConnectorTypesCVC", bundle: nil), forCellWithReuseIdentifier: "ConnectorTypesCVC")
        ConnectorTypeCollectionView.delegate = self
        ConnectorTypeCollectionView.dataSource = self
        
        if let layout = ConnectorTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        ConnectorTypeCollectionView.isScrollEnabled = false
        ConnectorTypeCollectionView.showsHorizontalScrollIndicator = false
        ConnectorTypeCollectionView.showsVerticalScrollIndicator = false
    }
    
    func updateCollectionViewHeight() {
        ConnectorTypeCollectionView.layoutIfNeeded()
        let contentHeight = ConnectorTypeCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        if collectionViewHeightConstraint.constant != contentHeight {
            collectionViewHeightConstraint.constant = contentHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func reloadCollectionViewData() {
        ConnectorTypeCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.updateCollectionViewHeight()
        }
    }
    
    func setupButtons() {
        setupCurrentTypeButton(acButton, title: "AC")
        setupCurrentTypeButton(dcButton, title: "DC")
        
        setupAccessTypeButton(commericalButton, title: "Commercial")
        setupAccessTypeButton(publicButton, title: "Public")
        setupAccessTypeButton(privateButton, title: "Private")
        
        clearFliterButton.layer.cornerRadius = 25
        clearFliterButton.layer.borderWidth = 1
        clearFliterButton.layer.borderColor = UIColor(hex: "379D67").cgColor
        clearFliterButton.setTitleColor(UIColor(hex: "379D67"), for: .normal)
        clearFliterButton.backgroundColor = .white
        clearFliterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        applyFilterbuttonAction.layer.cornerRadius = 25
        applyFilterbuttonAction.backgroundColor = UIColor(hex: "379D67")
        applyFilterbuttonAction.setTitleColor(.white, for: .normal)
        applyFilterbuttonAction.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func setupCurrentTypeButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.clipsToBounds = true
    }
    
    func setupAccessTypeButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.clipsToBounds = true
    }
    
    func stylizeCurrentTypeButton(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(hex: "379D67")
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor(hex: "379D67").cgColor
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func stylizeAccessTypeButton(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(hex: "379D67")
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor(hex: "379D67").cgColor
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    @IBAction func switchAction(_ sender: Any) {
    }
    
    @IBAction func acCurrentButtonAction(_ sender: UIButton) {
        stylizeCurrentTypeButton(acButton, isSelected: true)
        stylizeCurrentTypeButton(dcButton, isSelected: false)
    }
    
    @IBAction func dcCurrentButtonAction(_ sender: UIButton) {
        stylizeCurrentTypeButton(acButton, isSelected: false)
        stylizeCurrentTypeButton(dcButton, isSelected: true)
    }
    
    @IBAction func commercialButtonAction(_ sender: UIButton) {
        toggleAccessTypeButton(sender)
    }
    
    @IBAction func publicButtonAction(_ sender: UIButton) {
        toggleAccessTypeButton(sender)
    }
    
    @IBAction func privateButtonAction(_ sender: UIButton) {
        toggleAccessTypeButton(sender)
    }
    
    func toggleAccessTypeButton(_ button: UIButton) {
        let isSelected = button.backgroundColor == UIColor(hex: "379D67")
        stylizeAccessTypeButton(button, isSelected: !isSelected)
    }
    
    @IBAction func clearFilterButtonAction(_ sender: Any) {
        selectedConnectors.removeAll()
        reloadCollectionViewData()
        
        stylizeCurrentTypeButton(acButton, isSelected: false)
        stylizeCurrentTypeButton(dcButton, isSelected: false)
        stylizeAccessTypeButton(commericalButton, isSelected: false)
        stylizeAccessTypeButton(publicButton, isSelected: false)
        stylizeAccessTypeButton(privateButton, isSelected: false)
        
        `switch`.isOn = false
        availableChargersOnly.textColor = .darkGray
        
        chargingRangeslider.selectedMinValue = chargingRangeslider.minValue
        chargingRangeslider.selectedMaxValue = chargingRangeslider.maxValue
    }
    
    @IBAction func applyFilterButtonAction(_ sender: Any) {
        print("=== Filters Applied ===")
        print("Selected Connectors: \(selectedConnectors)")
        print("AC Selected: \(acButton.backgroundColor == UIColor(hex: "379D67"))")
        print("DC Selected: \(dcButton.backgroundColor == UIColor(hex: "379D67"))")
        print("Commercial: \(commericalButton.backgroundColor == UIColor(hex: "379D67"))")
        print("Public: \(publicButton.backgroundColor == UIColor(hex: "379D67"))")
        print("Private: \(privateButton.backgroundColor == UIColor(hex: "379D67"))")
        print("Available Only: \(`switch`.isOn)")
        print("Speed Range: \(Int(chargingRangeslider.selectedMinValue))kW - \(Int(chargingRangeslider.selectedMaxValue))kW")
        
        navigationController?.popViewController(animated: true)
    }
}

extension FilterPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return connector.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectorTypesCVC", for: indexPath) as! ConnectorTypesCVC
        let connectorType = connector[indexPath.row]
        cell.configure(with: connectorType.connector)
        
        let isSelected = selectedConnectors.contains(connectorType.connector)
        cell.setSelected(isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let connectorType = connector[indexPath.row].connector
        
        if selectedConnectors.contains(connectorType) {
            selectedConnectors.remove(connectorType)
        } else {
            selectedConnectors.insert(connectorType)
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        DispatchQueue.main.async { [weak self] in
            self?.updateCollectionViewHeight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = connector[indexPath.row].connector
        let width = calculateWidthForText(text)
        return CGSize(width: width + 60, height: 50)
    }
    
    func calculateWidthForText(_ text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return ceil(size.width)
    }
}

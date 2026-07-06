//
//  FiltersPageVC.swift
//  EVSmartCity
//
//  Created by Hitman on 01/07/26.

import UIKit

class FiltersPageVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var availableNowOnlyLabel: UILabel!
    @IBOutlet weak var hidesFullyOccupiedStationsLabel: UILabel!
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var connectorTypeTitleLabel: UILabel!
    @IBOutlet weak var basedOnYourVehicleLabel: UILabel!
    @IBOutlet weak var connectorTypeCollectionView: UICollectionView!
    @IBOutlet weak var powerLevelLabel: UILabel!
    @IBOutlet weak var powerLevelCollectionView: UICollectionView!
    @IBOutlet weak var priceLimitTitleLabel: UILabel!
    @IBOutlet weak var pricePerKWHLabel: UILabel!
    @IBOutlet weak var priceLimitSlider: RangeSeekSlider!
    @IBOutlet weak var onlyShowStationsWithinYourBudgetLabel: UILabel!
    @IBOutlet weak var reliabilityLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var reliabilitySwitch: UISwitch!
    @IBOutlet weak var highlyReliableStationsLabel: UILabel!
    @IBOutlet weak var showChargersWithLabel: UILabel!
    @IBOutlet weak var anyButton: UIButton!
    @IBOutlet weak var seventyPlusButton: UIButton!
    @IBOutlet weak var eightyPlusButton: UIButton!
    @IBOutlet weak var ninghtyPlusButton: UIButton!
    @IBOutlet weak var excelentLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var belowNeedsImprovementlabel: UILabel!
    @IBOutlet weak var networkOperatorLabel: UILabel!
    @IBOutlet var networkOperatorButton: [UIButton]!
    @IBOutlet weak var amenitiesLabel: UILabel!
    @IBOutlet var amenitiesButton: [UIButton]!
    @IBOutlet weak var greenEnergyOnlyLabel: UILabel!
    @IBOutlet weak var stationsWithrenewableMixLabel: UILabel!
    @IBOutlet weak var greenEnergySwitch: UISwitch!
    @IBOutlet weak var accessibilityTitleLabel: UILabel!
    @IBOutlet var accessibilityButton: [UIButton]!
    @IBOutlet weak var searchRadiusLabel: UILabel!
    @IBOutlet weak var searchRadiusKMLabel: UILabel!
    @IBOutlet weak var searchRadiusSlider: RangeSeekSlider!
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startingPriceLimitLabel: UILabel!
    @IBOutlet weak var endingPriceLimitLabel: UILabel!
    @IBOutlet weak var oneKMLabel: UILabel!
    @IBOutlet weak var fiftyKMLabel: UILabel!
    
    var connector = [
        ConnectorType(connector: "CCS2"),
        ConnectorType(connector: "AC001"),
        ConnectorType(connector: "CCS2"),
        ConnectorType(connector: "Type-2"),
        ConnectorType(connector: "Domestic"),
        ConnectorType(connector: "TESLA_R"),
        ConnectorType(connector: "TESLA_S")
    ]
    
    var powerLevels: [PowerLevelModel] = [
        PowerLevelModel(title: "Slow AC", powerRange: "≤7 kW"),
        PowerLevelModel(title: "Fast AC", powerRange: "7–22 kW"),
        PowerLevelModel(title: "Rapid DC", powerRange: "50–150 kW"),
        PowerLevelModel(title: "Ultra", powerRange: ">150 kW")
    ]
    
    var selectedConnectors: Set<String> = []
    var selectedPowerLevelIndex: Int?
    var selectedReliabilityButton: UIButton?
    var selectedNetworkOperators: Set<Int> = []
    var selectedAmenities: Set<Int> = []
    var selectedAccessibility: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clearAllButtonAction(_ sender: Any) {
        
        availableSwitch.isOn = false
        reliabilitySwitch.isOn = false
        greenEnergySwitch.isOn = false
        
        selectedConnectors.removeAll()
        connectorTypeCollectionView.reloadData()
        
        selectedPowerLevelIndex = nil
        powerLevelCollectionView.reloadData()
        
        priceLimitSlider.selectedMaxValue = 1
        priceLimitSlider.layoutIfNeeded()
        priceLimitSlider.setNeedsLayout()
        pricePerKWHLabel.text = "SAR \(String(format: "%.2f", priceLimitSlider.selectedMaxValue)) / kWh"
        
        searchRadiusSlider.selectedMaxValue = 5
        searchRadiusSlider.layoutIfNeeded()
        searchRadiusSlider.setNeedsLayout()
        
        searchRadiusKMLabel.text = "\(Int(searchRadiusSlider.selectedMaxValue)) km"
        
        selectedReliabilityButton = nil
        
        let reliabilityButtons = [
            anyButton,
            seventyPlusButton,
            eightyPlusButton,
            ninghtyPlusButton
        ]
        
        reliabilityButtons.forEach { button in
            button?.backgroundColor = .clear
            button?.layer.borderColor = UIColor.systemGray4.cgColor
            
            if var config = button?.configuration {
                config.baseForegroundColor = .label
                button?.configuration = config
            } else {
                button?.setTitleColor(.label, for: .normal)
            }
        }
        
        selectedNetworkOperators.removeAll()
        networkOperatorButton.forEach { button in
            button.setImage(UIImage(systemName: "square"), for: .normal)
            
            if var config = button.configuration {
                config.baseForegroundColor = .label
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                button.configuration = config
            } else {
                button.tintColor = .systemGray3
                button.setTitleColor(.label, for: .normal)
            }
        }
        selectedAmenities.removeAll()
        
        amenitiesButton.forEach { button in
            button.setImage(UIImage(systemName: "square"), for: .normal)
            if var config = button.configuration {
                config.baseForegroundColor = .label
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                button.configuration = config
            } else {
                button.tintColor = .systemGray3
                button.setTitleColor(.label, for: .normal)
            }
        }
        
        selectedAccessibility.removeAll()
        
        accessibilityButton.forEach { button in
            button.setImage(UIImage(systemName: "square"), for: .normal)
            if var config = button.configuration {
                config.baseForegroundColor = .label
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                button.configuration = config
            } else {
                button.tintColor = .systemGray3
                button.setTitleColor(.label, for: .normal)
            }
        }
        
        updateCollectionViewHeight()
    }
    
    @IBAction func anyButtonAction(_ sender: Any) {
        selectReliabilityButton(anyButton)
    }
    
    @IBAction func seventyPlusButtonAction(_ sender: Any) {
        selectReliabilityButton(seventyPlusButton)
    }
    
    @IBAction func eightyPlusButtonAction(_ sender: Any) {
        selectReliabilityButton(eightyPlusButton)
    }
    
    @IBAction func ninghtyPlusButtonAction(_ sender: Any) {
        selectReliabilityButton(ninghtyPlusButton)
    }
    
    @IBAction func networkOperatorButtonAction(_ sender: UIButton) {
        if selectedNetworkOperators.contains(sender.tag) {
            selectedNetworkOperators.remove(sender.tag)
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = .systemGray3
                sender.setTitleColor(.label, for: .normal)
            }
        } else {
            selectedNetworkOperators.insert(sender.tag)
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return UIColor(hex: "#379D67")
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = UIColor(hex: "#379D67")
                sender.setTitleColor(.label, for: .normal)
            }
        }
    }
    
    @IBAction func amenitiesButtonAction(_ sender: UIButton) {
        if selectedAmenities.contains(sender.tag) {
            selectedAmenities.remove(sender.tag)
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = .systemGray3
                sender.setTitleColor(.label, for: .normal)
            }
        } else {
            selectedAmenities.insert(sender.tag)
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return UIColor(hex: "#379D67")
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = UIColor(hex: "#379D67")
                sender.setTitleColor(.label, for: .normal)
            }
        }
    }
    
    @IBAction func accessibilityButtonAction(_ sender: UIButton) {
        if selectedAccessibility.contains(sender.tag) {
            selectedAccessibility.remove(sender.tag)
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return .systemGray3
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = .systemGray3
                sender.setTitleColor(.label, for: .normal)
            }
        } else {
            selectedAccessibility.insert(sender.tag)
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            if var config = sender.configuration {
                config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                    return UIColor(hex: "#379D67")
                }
                config.baseForegroundColor = .label
                sender.configuration = config
            } else {
                sender.tintColor = UIColor(hex: "#379D67")
                sender.setTitleColor(.label, for: .normal)
            }
        }
    }
    
    @IBAction func applyFilterButtonAction(_ sender: Any) {
    }
    
}

extension FiltersPageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == connectorTypeCollectionView {
            return connector.count
        } else if collectionView == powerLevelCollectionView {
            return powerLevels.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == connectorTypeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectorTypesCVC", for: indexPath) as! ConnectorTypesCVC
            let connectorType = connector[indexPath.row]
            cell.configure(with: connectorType.connector)
            let isSelected = selectedConnectors.contains(connectorType.connector)
            cell.setSelected(isSelected)
            return cell
        } else if collectionView == powerLevelCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PowerLevelCVC", for: indexPath) as! PowerLevelCVC
            let item = powerLevels[indexPath.item]
            cell.chargerTypeLabel.text = item.title
            cell.chargerPowerLabel.text = item.powerRange
            let isSelected = selectedPowerLevelIndex == indexPath.item
            cell.configure(isSelected: isSelected)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == connectorTypeCollectionView {
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
        } else if collectionView == powerLevelCollectionView {
            selectedPowerLevelIndex = indexPath.item
            powerLevelCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == connectorTypeCollectionView {
            let text = connector[indexPath.row].connector
            let width = calculateWidthForText(text)
            return CGSize(width: width + 60, height: 50)
        } else {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalHorizontalSpacing = layout.sectionInset.left +
            layout.sectionInset.right +
            layout.minimumInteritemSpacing
            let width = (collectionView.frame.width - totalHorizontalSpacing) / 2
            let height: CGFloat = 74
            return CGSize(width: width, height: height)
        }
    }
    
    func calculateWidthForText(_ text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return ceil(size.width)
    }
}

extension FiltersPageVC {
    func setUpUI() {
        selectedConnectors.removeAll()
        selectedPowerLevelIndex = nil
        selectedNetworkOperators.removeAll()
        selectedAmenities.removeAll()
        selectedAccessibility.removeAll()
        selectedReliabilityButton = nil
        
        connectorTypeCollectionView.reloadData()
        powerLevelCollectionView.reloadData()
        setupCollectionView()
        setupPriceSlider()
        setupSearchRadiusSlider()
        setupReliabilityButtons()
        setupCheckboxButtons()
    }
    
    func setupPriceSlider() {
        
        priceLimitSlider.minValue = 0.5
        priceLimitSlider.maxValue = 5.0
        
        priceLimitSlider.disableRange = true
        priceLimitSlider.selectedMaxValue = 1
        
        priceLimitSlider.hideLabels = true
        
        priceLimitSlider.tintColor = UIColor.systemGray4
        priceLimitSlider.colorBetweenHandles = UIColor(hex: "#379D67")
        
        priceLimitSlider.enableStep = false
        priceLimitSlider.delegate = self
        
        startingPriceLimitLabel.text = "SAR \(String(format: "%.2f", priceLimitSlider.minValue))"
        endingPriceLimitLabel.text = "SAR \(String(format: "%.2f", priceLimitSlider.maxValue))"
        pricePerKWHLabel.text = "SAR \(String(format: "%.2f", priceLimitSlider.selectedMaxValue)) / kWh"
    }
    
    func setupCollectionView() {
        connectorTypeCollectionView.register(UINib(nibName: "ConnectorTypesCVC", bundle: nil), forCellWithReuseIdentifier: "ConnectorTypesCVC")
        connectorTypeCollectionView.delegate = self
        connectorTypeCollectionView.dataSource = self
        
        if let layout = connectorTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        connectorTypeCollectionView.isScrollEnabled = false
        connectorTypeCollectionView.showsHorizontalScrollIndicator = false
        connectorTypeCollectionView.showsVerticalScrollIndicator = false
        
        powerLevelCollectionView.register(UINib(nibName: "PowerLevelCVC", bundle: nil), forCellWithReuseIdentifier: "PowerLevelCVC")
        powerLevelCollectionView.delegate = self
        powerLevelCollectionView.dataSource = self
        
        if let layouts = powerLevelCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.scrollDirection = .vertical
            layouts.estimatedItemSize = .zero
            layouts.minimumLineSpacing = 12
            layouts.minimumInteritemSpacing = 12
            layouts.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        powerLevelCollectionView.isScrollEnabled = false
        powerLevelCollectionView.showsHorizontalScrollIndicator = false
        powerLevelCollectionView.showsVerticalScrollIndicator = false
    }
    
    func updateCollectionViewHeight() {
        connectorTypeCollectionView.layoutIfNeeded()
        let contentHeight = connectorTypeCollectionView.collectionViewLayout.collectionViewContentSize.height
        if collectionViewHeightConstraint.constant != contentHeight {
            collectionViewHeightConstraint.constant = contentHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func reloadCollectionViewData() {
        connectorTypeCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.updateCollectionViewHeight()
        }
    }
    
    func setupReliabilityButtons() {
        let buttons = [anyButton, seventyPlusButton, eightyPlusButton, ninghtyPlusButton]
        buttons.forEach {
            $0?.layer.cornerRadius = 12
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.systemGray4.cgColor
            $0?.backgroundColor = .clear
            $0?.setTitleColor(.label, for: .normal)
        }
    }
    
    func selectReliabilityButton(_ button: UIButton) {
        let buttons = [anyButton, seventyPlusButton, eightyPlusButton, ninghtyPlusButton]
        buttons.forEach { btn in
            btn?.backgroundColor = .clear
            btn?.layer.borderColor = UIColor.systemGray4.cgColor
            if var config = btn?.configuration {
                config.baseForegroundColor = .label
                btn?.configuration = config
            } else {
                btn?.setTitleColor(.label, for: .normal)
            }
        }
        
        button.backgroundColor = UIColor(hex: "#379D67")
        button.layer.borderColor = UIColor(hex: "#379D67").cgColor
        
        if var config = button.configuration {
            config.baseForegroundColor = .white
            button.configuration = config
        } else {
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    func setupCheckboxButtons() {
        
        [networkOperatorButton, amenitiesButton, accessibilityButton].forEach { buttons in
            buttons?.enumerated().forEach { index, button in
                button.tag = index
                button.setImage(UIImage(systemName: "square"), for: .normal)
                
                if var config = button.configuration {
                    config.baseForegroundColor = .label
                    config.imageColorTransformer = UIConfigurationColorTransformer { _ in
                        return .systemGray3
                    }
                    button.configuration = config
                } else {
                    button.tintColor = .systemGray3
                    button.setTitleColor(.label, for: .normal)
                }
                
                button.contentHorizontalAlignment = .leading
                button.imageView?.contentMode = .scaleAspectFit
                button.semanticContentAttribute = .forceLeftToRight
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            }
        }
    }
    
    func setupSearchRadiusSlider() {
        
        searchRadiusSlider.minValue = 1
        searchRadiusSlider.maxValue = 50
        
        searchRadiusSlider.disableRange = true
        searchRadiusSlider.selectedMaxValue = 5
        
        searchRadiusSlider.hideLabels = true
        
        searchRadiusSlider.tintColor = UIColor.systemGray4
        searchRadiusSlider.colorBetweenHandles = UIColor(hex: "#379D67")
        
        searchRadiusSlider.enableStep = false
        searchRadiusSlider.delegate = self
        
        oneKMLabel.text = "\(Int(searchRadiusSlider.minValue)) km"
        fiftyKMLabel.text = "\(Int(searchRadiusSlider.maxValue)) km"
        searchRadiusKMLabel.text = "\(Int(searchRadiusSlider.selectedMaxValue)) km"
    }
}

extension FiltersPageVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider,didChange minValue: CGFloat,maxValue: CGFloat) {
        if slider == priceLimitSlider {
            startingPriceLimitLabel.text = "SAR \(String(format: "%.2f", slider.minValue))"
            endingPriceLimitLabel.text = "SAR \(String(format: "%.2f", slider.maxValue))"
            pricePerKWHLabel.text = "SAR \(String(format: "%.2f", maxValue)) / kWh"
        } else if slider == searchRadiusSlider {
            oneKMLabel.text = "\(Int(slider.minValue)) km"
            fiftyKMLabel.text = "\(Int(slider.maxValue)) km"
            searchRadiusKMLabel.text = "\(Int(maxValue)) km"
        }
    }
}

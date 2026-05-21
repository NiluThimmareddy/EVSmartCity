//
//  ChargingHelpVC.swift
//  EVSmartCity
//
//  Created by Hitman on 19/05/26.
//

import UIKit

class ChargingHelpVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var chargingHelpLabel: UILabel!
    @IBOutlet var openAndCloseButton: [UIButton]!
    @IBOutlet var lineView: [UIView]!
    @IBOutlet var wasThisHelpFullLabel: [UILabel]!
    @IBOutlet var likeButton: [UIButton]!
    @IBOutlet var dislikeButton: [UIButton]!
    @IBOutlet weak var whyIsMyChargingStationLabel: UILabel!
    @IBOutlet weak var makeSureYourVechicleProperlylabel: UILabel!
    @IBOutlet weak var whyDidChargingStopUnexpectedlylabel: UILabel!
    @IBOutlet weak var chargingMayStopDueToPoorNetworkLabel: UILabel!
    @IBOutlet weak var whyIsChargingSpeedSlowLabel: UILabel!
    @IBOutlet weak var chargingSpeedDependsOnChargingTypeLabel: UILabel!
    @IBOutlet weak var whatShouldDoIfMyEVChargingLabel: UILabel!
    @IBOutlet weak var ensureYourVehicleSecurelyLabel: UILabel!
    @IBOutlet weak var howDoICheckChargerAvailabilityLabel: UILabel!
    @IBOutlet weak var openTheMapOrNearChargersSctionlabel: UILabel!
    @IBOutlet weak var whatConnectorTypesAreSupportedLabel: UILabel!
    @IBOutlet weak var appSupportsPopularEvConnectorsLabel: UILabel!
    @IBOutlet weak var whatShouldIDoChargerlabel: UILabel!
    @IBOutlet weak var checkWhetherTheConnectorisInsertedLabel: UILabel!
    @IBOutlet weak var whyIsMyChargingStationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whyDidChargingStopUnexpectedlyViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whyIsChargingSpeedSlowViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whatShouldIDoMyEVViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoCheckChargerAvailabilityViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whatConnectorTypesSupportedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whatShouldIDoIfTheChargerViewHeightConstraint: NSLayoutConstraint!
    
    private var isHowDoIStartExpanded = false
    private var isHowDoIStopExpanded = false
    private var isPaymentMethodsExpanded = false
    private var isViewMyChargingExpanded = false
    private var isCanIReserveExpanded = false
    private var isChargingNotWorkExpanded = false
    
    private let collapsedHeight: CGFloat = 80
    private let expandedHeightHowDoIStart: CGFloat = 220
    private let expandedHeightHowDoIStop: CGFloat = 230
    private let expandedHeightPaymentMethods: CGFloat = 230
    private let expandedHeightViewMyCharging: CGFloat = 190
    private let expandedHeightCanIReserve: CGFloat = 200
    private let expandedHeightChargingNotWork: CGFloat = 200
    private let expandedHeightCharging: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialCollapsedState()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func openAndClosebuttonAction(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if button == openAndCloseButton[0] {
            
            isHowDoIStartExpanded.toggle()
            
            whyIsMyChargingStationViewHeightConstraint.constant = isHowDoIStartExpanded ? expandedHeightHowDoIStart : collapsedHeight
            
            makeSureYourVechicleProperlylabel.isHidden = !isHowDoIStartExpanded
            wasThisHelpFullLabel[0].isHidden = !isHowDoIStartExpanded
            likeButton[0].isHidden = !isHowDoIStartExpanded
            dislikeButton[0].isHidden = !isHowDoIStartExpanded
            lineView[0].isHidden = !isHowDoIStartExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[0],label: whyIsMyChargingStationLabel, isExpanded: isHowDoIStartExpanded)
            
        } else if button == openAndCloseButton[1] {
            
            isHowDoIStopExpanded.toggle()
            
            whyDidChargingStopUnexpectedlyViewHeightConstraint.constant = isHowDoIStopExpanded ? expandedHeightHowDoIStop : collapsedHeight
            
            chargingMayStopDueToPoorNetworkLabel.isHidden = !isHowDoIStopExpanded
            wasThisHelpFullLabel[1].isHidden = !isHowDoIStopExpanded
            likeButton[1].isHidden = !isHowDoIStopExpanded
            dislikeButton[1].isHidden = !isHowDoIStopExpanded
            lineView[1].isHidden = !isHowDoIStopExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[1],label: whyDidChargingStopUnexpectedlylabel, isExpanded: isHowDoIStopExpanded)
            
        } else if button == openAndCloseButton[2] {
            
            isPaymentMethodsExpanded.toggle()
            
            whyIsChargingSpeedSlowViewHeightConstraint.constant = isPaymentMethodsExpanded ? expandedHeightPaymentMethods : collapsedHeight
            
            chargingSpeedDependsOnChargingTypeLabel.isHidden = !isPaymentMethodsExpanded
            wasThisHelpFullLabel[2].isHidden = !isPaymentMethodsExpanded
            likeButton[2].isHidden = !isPaymentMethodsExpanded
            dislikeButton[2].isHidden = !isPaymentMethodsExpanded
            lineView[2].isHidden = !isPaymentMethodsExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[2],label: whyIsChargingSpeedSlowLabel, isExpanded: isPaymentMethodsExpanded)
            
        } else if button == openAndCloseButton[3] {
            
            isViewMyChargingExpanded.toggle()
            
            whatShouldIDoMyEVViewHeightConstraint.constant = isViewMyChargingExpanded ? expandedHeightViewMyCharging : collapsedHeight
            
            ensureYourVehicleSecurelyLabel.isHidden = !isViewMyChargingExpanded
            wasThisHelpFullLabel[3].isHidden = !isViewMyChargingExpanded
            likeButton[3].isHidden = !isViewMyChargingExpanded
            dislikeButton[3].isHidden = !isViewMyChargingExpanded
            lineView[3].isHidden = !isViewMyChargingExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[3],label: whatShouldDoIfMyEVChargingLabel, isExpanded: isViewMyChargingExpanded)
            
        } else if button == openAndCloseButton[4] {
            
            isCanIReserveExpanded.toggle()
            
            howDoCheckChargerAvailabilityViewHeightConstraint.constant = isCanIReserveExpanded ? expandedHeightCanIReserve : collapsedHeight
            
            openTheMapOrNearChargersSctionlabel.isHidden = !isCanIReserveExpanded
            wasThisHelpFullLabel[4].isHidden = !isCanIReserveExpanded
            likeButton[4].isHidden = !isCanIReserveExpanded
            dislikeButton[4].isHidden = !isCanIReserveExpanded
            lineView[4].isHidden = !isCanIReserveExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[4],label: howDoICheckChargerAvailabilityLabel, isExpanded: isCanIReserveExpanded)
            
        } else if button == openAndCloseButton[5] {
            
            isChargingNotWorkExpanded.toggle()
            
            whatConnectorTypesSupportedViewHeightConstraint.constant = isChargingNotWorkExpanded ? expandedHeightChargingNotWork : collapsedHeight
            
            appSupportsPopularEvConnectorsLabel.isHidden = !isChargingNotWorkExpanded
            wasThisHelpFullLabel[5].isHidden = !isChargingNotWorkExpanded
            likeButton[5].isHidden = !isChargingNotWorkExpanded
            dislikeButton[5].isHidden = !isChargingNotWorkExpanded
            lineView[5].isHidden = !isChargingNotWorkExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[5],label: whatConnectorTypesAreSupportedLabel, isExpanded: isChargingNotWorkExpanded)
        } else if button == openAndCloseButton[6] {
            
            isChargingNotWorkExpanded.toggle()
            
            whatShouldIDoIfTheChargerViewHeightConstraint.constant = isChargingNotWorkExpanded ? expandedHeightChargingNotWork : collapsedHeight
            
            checkWhetherTheConnectorisInsertedLabel.isHidden = !isChargingNotWorkExpanded
            wasThisHelpFullLabel[6].isHidden = !isChargingNotWorkExpanded
            likeButton[6].isHidden = !isChargingNotWorkExpanded
            dislikeButton[6].isHidden = !isChargingNotWorkExpanded
            lineView[6].isHidden = !isChargingNotWorkExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[6],label: whatShouldIDoChargerlabel, isExpanded: isChargingNotWorkExpanded)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton,
              let index = likeButton.firstIndex(of: button) else { return }
        
        let isSelected = likeButton[index].currentImage == UIImage(systemName: "hand.thumbsup.fill")
        
        if isSelected {
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        } else {
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            dislikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        }
        
        likeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
        dislikeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton,
              let index = dislikeButton.firstIndex(of: button) else { return }
        
        let isSelected = dislikeButton[index].currentImage == UIImage(systemName: "hand.thumbsdown.fill")
        
        if isSelected {
            dislikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        } else {
            dislikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        
        likeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
        dislikeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
    }
    
    private func updateExpandButtonUI(button: UIButton,label: UILabel, isExpanded: Bool) {
        if isExpanded {
            button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            button.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            button.tintColor = UIColor(hex: "#379D67")
            label.textColor = UIColor(hex: "#379D67")
        } else {
            button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            button.backgroundColor = UIColor.label.withAlphaComponent(0.1)
            button.tintColor = UIColor.label
            label.textColor = .label
        }
        button.configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
    }
    
    private func setInitialCollapsedState() {
        whyIsMyChargingStationViewHeightConstraint.constant = collapsedHeight
        whyDidChargingStopUnexpectedlyViewHeightConstraint.constant = collapsedHeight
        whyIsChargingSpeedSlowViewHeightConstraint.constant = collapsedHeight
        whatShouldIDoMyEVViewHeightConstraint.constant = collapsedHeight
        howDoCheckChargerAvailabilityViewHeightConstraint.constant = collapsedHeight
        whatConnectorTypesSupportedViewHeightConstraint.constant = collapsedHeight
        whatShouldIDoIfTheChargerViewHeightConstraint.constant = collapsedHeight

        makeSureYourVechicleProperlylabel.isHidden = true
        chargingMayStopDueToPoorNetworkLabel.isHidden = true
        chargingSpeedDependsOnChargingTypeLabel.isHidden = true
        ensureYourVehicleSecurelyLabel.isHidden = true
        openTheMapOrNearChargersSctionlabel.isHidden = true
        appSupportsPopularEvConnectorsLabel.isHidden = true
        checkWhetherTheConnectorisInsertedLabel.isHidden = true
        
        whyIsMyChargingStationLabel.textColor = .label
        whyDidChargingStopUnexpectedlylabel.textColor = .label
        whyIsChargingSpeedSlowLabel.textColor = .label
        whatShouldDoIfMyEVChargingLabel.textColor = .label
        howDoICheckChargerAvailabilityLabel.textColor = .label
        whatConnectorTypesAreSupportedLabel.textColor = .label
        whatShouldIDoChargerlabel.textColor = .label
        
        for label in wasThisHelpFullLabel {
            label.isHidden = true
        }
        for button in likeButton {
            button.isHidden = true
        }
        for button in dislikeButton {
            button.isHidden = true
        }
        
        for line in lineView {
            line.isHidden = true
        }
        
        view.layoutIfNeeded()
    }
}

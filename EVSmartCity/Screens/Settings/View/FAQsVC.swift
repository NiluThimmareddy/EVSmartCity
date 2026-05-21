//
//  FAQsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 19/05/26.

import UIKit

class FAQsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var faqsLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var howDoIStartChargingSessionView: UIView!
    @IBOutlet weak var howDoIstartViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoIStartChargingLabel: UILabel!
    @IBOutlet var openAndCloseViewButton: [UIButton]!
    @IBOutlet weak var toStartChargingSessionLabel: UILabel!
    @IBOutlet var wasThishelpFulLabel: [UILabel]!
    @IBOutlet var likeButton: [UIButton]!
    @IBOutlet var disLikeButton: [UIButton]!
    @IBOutlet weak var howDoiStopView: UIView!
    @IBOutlet weak var howDoiStopViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoiStopLabel: UILabel!
    @IBOutlet weak var openTheActiveChargingLabel: UILabel!
    @IBOutlet weak var whatPaymentMethodsView: UIView!
    @IBOutlet weak var whatPaymentMethodsViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var whatPaymentMethodsLabel: UILabel!
    @IBOutlet weak var weSupportVisaLabel: UILabel!
    @IBOutlet weak var howDoViewMyChargingView: UIView!
    @IBOutlet weak var howDoViewMyChagingViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoViewMyChargingLabel: UILabel!
    @IBOutlet weak var goToProfileLabel: UILabel!
    @IBOutlet weak var canIReserveView: UIView!
    @IBOutlet weak var canIReserveViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var canIReserveLabel: UILabel!
    @IBOutlet weak var yesSomeChargingLabel: UILabel!
    @IBOutlet weak var whatIfChargingNotWorkView: UIView!
    @IBOutlet weak var whatIfChargingNotWorkViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whatIfTheChargingNotWrkingLabel: UILabel!
    @IBOutlet weak var ensureTheConnectorLabel: UILabel!
    @IBOutlet var lineView: [UIView]!
    
    private var isHowDoIStartExpanded = false
    private var isHowDoIStopExpanded = false
    private var isPaymentMethodsExpanded = false
    private var isViewMyChargingExpanded = false
    private var isCanIReserveExpanded = false
    private var isChargingNotWorkExpanded = false
    
    private let collapsedHeight: CGFloat = 70
    private let expandedHeightHowDoIStart: CGFloat = 200
    private let expandedHeightHowDoIStop: CGFloat = 200
    private let expandedHeightPaymentMethods: CGFloat = 200
    private let expandedHeightViewMyCharging: CGFloat = 200
    private let expandedHeightCanIReserve: CGFloat = 200
    private let expandedHeightChargingNotWork: CGFloat = 230
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialCollapsedState()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func openAndCloseViewButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if button == openAndCloseViewButton[0] {
            
            isHowDoIStartExpanded.toggle()
            
            howDoIstartViewHeightConstraint.constant = isHowDoIStartExpanded ? expandedHeightHowDoIStart : collapsedHeight
            
            toStartChargingSessionLabel.isHidden = !isHowDoIStartExpanded
            wasThishelpFulLabel[0].isHidden = !isHowDoIStartExpanded
            likeButton[0].isHidden = !isHowDoIStartExpanded
            disLikeButton[0].isHidden = !isHowDoIStartExpanded
            lineView[0].isHidden = !isHowDoIStartExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[0],label: howDoIStartChargingLabel, isExpanded: isHowDoIStartExpanded)
            
        } else if button == openAndCloseViewButton[1] {
            
            isHowDoIStopExpanded.toggle()
            
            howDoiStopViewHeightConstraint.constant = isHowDoIStopExpanded ? expandedHeightHowDoIStop : collapsedHeight
            
            openTheActiveChargingLabel.isHidden = !isHowDoIStopExpanded
            wasThishelpFulLabel[1].isHidden = !isHowDoIStopExpanded
            likeButton[1].isHidden = !isHowDoIStopExpanded
            disLikeButton[1].isHidden = !isHowDoIStopExpanded
            lineView[1].isHidden = !isHowDoIStopExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[1],label: howDoiStopLabel, isExpanded: isHowDoIStopExpanded)
            
        } else if button == openAndCloseViewButton[2] {
            
            isPaymentMethodsExpanded.toggle()
            
            whatPaymentMethodsViewHeightConstraints.constant = isPaymentMethodsExpanded ? expandedHeightPaymentMethods : collapsedHeight
            
            weSupportVisaLabel.isHidden = !isPaymentMethodsExpanded
            wasThishelpFulLabel[2].isHidden = !isPaymentMethodsExpanded
            likeButton[2].isHidden = !isPaymentMethodsExpanded
            disLikeButton[2].isHidden = !isPaymentMethodsExpanded
            lineView[2].isHidden = !isPaymentMethodsExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[2],label: whatPaymentMethodsLabel, isExpanded: isPaymentMethodsExpanded)
            
        } else if button == openAndCloseViewButton[3] {
            
            isViewMyChargingExpanded.toggle()
            
            howDoViewMyChagingViewHeightConstraint.constant = isViewMyChargingExpanded ? expandedHeightViewMyCharging : collapsedHeight
            
            goToProfileLabel.isHidden = !isViewMyChargingExpanded
            wasThishelpFulLabel[3].isHidden = !isViewMyChargingExpanded
            likeButton[3].isHidden = !isViewMyChargingExpanded
            disLikeButton[3].isHidden = !isViewMyChargingExpanded
            lineView[3].isHidden = !isViewMyChargingExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[3],label: howDoViewMyChargingLabel, isExpanded: isViewMyChargingExpanded)
            
        } else if button == openAndCloseViewButton[4] {
            
            isCanIReserveExpanded.toggle()
            
            canIReserveViewHeightConstraint.constant = isCanIReserveExpanded ? expandedHeightCanIReserve : collapsedHeight
            
            yesSomeChargingLabel.isHidden = !isCanIReserveExpanded
            wasThishelpFulLabel[4].isHidden = !isCanIReserveExpanded
            likeButton[4].isHidden = !isCanIReserveExpanded
            disLikeButton[4].isHidden = !isCanIReserveExpanded
            lineView[4].isHidden = !isCanIReserveExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[4],label: canIReserveLabel, isExpanded: isCanIReserveExpanded)
            
        } else if button == openAndCloseViewButton[5] {
            
            isChargingNotWorkExpanded.toggle()
            
            whatIfChargingNotWorkViewHeightConstraint.constant = isChargingNotWorkExpanded ? expandedHeightChargingNotWork : collapsedHeight
            
            ensureTheConnectorLabel.isHidden = !isChargingNotWorkExpanded
            wasThishelpFulLabel[5].isHidden = !isChargingNotWorkExpanded
            likeButton[5].isHidden = !isChargingNotWorkExpanded
            disLikeButton[5].isHidden = !isChargingNotWorkExpanded
            lineView[5].isHidden = !isChargingNotWorkExpanded
            
            updateExpandButtonUI(button: openAndCloseViewButton[5],label: canIReserveLabel, isExpanded: isChargingNotWorkExpanded)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
    
    @IBAction func likeButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton,
              let index = likeButton.firstIndex(of: button) else { return }
        
        let isSelected = likeButton[index].currentImage == UIImage(systemName: "hand.thumbsup.fill")
        
        if isSelected {
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        } else {
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            disLikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        }
        
        likeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
        disLikeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
    }

    @IBAction func dislikeButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton,
              let index = disLikeButton.firstIndex(of: button) else { return }
        
        let isSelected = disLikeButton[index].currentImage == UIImage(systemName: "hand.thumbsdown.fill")
        
        if isSelected {
            disLikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        } else {
            disLikeButton[index].setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            likeButton[index].setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        
        likeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
        disLikeButton[index].configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(scale: .small)
    }
    
    private func setInitialCollapsedState() {
        howDoIstartViewHeightConstraint.constant = collapsedHeight
        howDoiStopViewHeightConstraint.constant = collapsedHeight
        whatPaymentMethodsViewHeightConstraints.constant = collapsedHeight
        howDoViewMyChagingViewHeightConstraint.constant = collapsedHeight
        canIReserveViewHeightConstraint.constant = collapsedHeight
        whatIfChargingNotWorkViewHeightConstraint.constant = collapsedHeight
        
        toStartChargingSessionLabel.isHidden = true
        openTheActiveChargingLabel.isHidden = true
        weSupportVisaLabel.isHidden = true
        goToProfileLabel.isHidden = true
        yesSomeChargingLabel.isHidden = true
        ensureTheConnectorLabel.isHidden = true
        
        howDoIStartChargingLabel.textColor = .label
        howDoiStopLabel.textColor = .label
        whatPaymentMethodsLabel.textColor = .label
        howDoViewMyChargingLabel.textColor = .label
        canIReserveLabel.textColor = .label
        whatIfTheChargingNotWrkingLabel.textColor = .label
        
        for label in wasThishelpFulLabel {
            label.isHidden = true
        }
        for button in likeButton {
            button.isHidden = true
        }
        for button in disLikeButton {
            button.isHidden = true
        }
        
        for line in lineView {
            line.isHidden = true
        }
        
        view.layoutIfNeeded()
    }
}




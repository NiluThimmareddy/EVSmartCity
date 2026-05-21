//
//  BillingAndPaymentsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 19/05/26.
//

import UIKit

class BillingAndPaymentsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var billingAndPaymentLabel: UILabel!
    @IBOutlet weak var whatPaymentMethodsLabel: UILabel!
    @IBOutlet var openAndCloseButton: [UIButton]!
    @IBOutlet var wasThisHelpfulLabel: [UILabel]!
    @IBOutlet var likeButton: [UIButton]!
    @IBOutlet var dislikeButton: [UIButton]!
    @IBOutlet var lineView: [UIView]!
    @IBOutlet weak var weAcceptCreditCardLabel: UILabel!
    @IBOutlet weak var howDoIAddPaymentMethodLabel: UILabel!
    @IBOutlet weak var goToProfilePaymentLabel: UILabel!
    @IBOutlet weak var howDoIRemovePaymentMethodLabel: UILabel!
    @IBOutlet weak var paymentMethodAndTapAddPaymentLabel: UILabel!
    @IBOutlet weak var howDoRefundWorksLabel: UILabel!
    @IBOutlet weak var refundsAreProcessedAfterLabel: UILabel!
    @IBOutlet weak var howDoIDownloadInvoiceLabel: UILabel!
    @IBOutlet weak var openChargingHistoryOrTransactionLabel: UILabel!
    @IBOutlet weak var howLongDoesItTakeToRefundLabel: UILabel!
    @IBOutlet weak var refundUsuallyTakesLabel: UILabel!
    @IBOutlet weak var whyWasMyPaymentDeclinedLabel: UILabel!
    @IBOutlet weak var yourPaymentMaybeDeclinedLabel: UILabel!
    @IBOutlet weak var whatPaymentMethodViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoAddPaymentMethodViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoRemovePaymentMethodViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoRefundWorkViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howDoDownloadAnInvoiceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howLongDoesTakeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whyWasMyPaymentDeclinedViewHeightConstraint: NSLayoutConstraint!
    
    
    private var isHowDoIStartExpanded = false
    private var isHowDoIStopExpanded = false
    private var isPaymentMethodsExpanded = false
    private var isViewMyChargingExpanded = false
    private var isCanIReserveExpanded = false
    private var isChargingNotWorkExpanded = false
    
    private let collapsedHeight: CGFloat = 70
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
    
    @IBAction func openAndCloseButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if button == openAndCloseButton[0] {
            
            isHowDoIStartExpanded.toggle()
            
            whatPaymentMethodViewHeightConstraint.constant = isHowDoIStartExpanded ? expandedHeightHowDoIStart : collapsedHeight
            
            weAcceptCreditCardLabel.isHidden = !isHowDoIStartExpanded
            wasThisHelpfulLabel[0].isHidden = !isHowDoIStartExpanded
            likeButton[0].isHidden = !isHowDoIStartExpanded
            dislikeButton[0].isHidden = !isHowDoIStartExpanded
            lineView[0].isHidden = !isHowDoIStartExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[0],label: whatPaymentMethodsLabel, isExpanded: isHowDoIStartExpanded)
            
        } else if button == openAndCloseButton[1] {
            
            isHowDoIStopExpanded.toggle()
            
            howDoAddPaymentMethodViewHeightConstraint.constant = isHowDoIStopExpanded ? expandedHeightHowDoIStop : collapsedHeight
            
            goToProfilePaymentLabel.isHidden = !isHowDoIStopExpanded
            wasThisHelpfulLabel[1].isHidden = !isHowDoIStopExpanded
            likeButton[1].isHidden = !isHowDoIStopExpanded
            dislikeButton[1].isHidden = !isHowDoIStopExpanded
            lineView[1].isHidden = !isHowDoIStopExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[1],label: howDoIAddPaymentMethodLabel, isExpanded: isHowDoIStopExpanded)
            
        } else if button == openAndCloseButton[2] {
            
            isPaymentMethodsExpanded.toggle()
            
            howDoRemovePaymentMethodViewHeightConstraint.constant = isPaymentMethodsExpanded ? expandedHeightPaymentMethods : collapsedHeight
            
            paymentMethodAndTapAddPaymentLabel.isHidden = !isPaymentMethodsExpanded
            wasThisHelpfulLabel[2].isHidden = !isPaymentMethodsExpanded
            likeButton[2].isHidden = !isPaymentMethodsExpanded
            dislikeButton[2].isHidden = !isPaymentMethodsExpanded
            lineView[2].isHidden = !isPaymentMethodsExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[2],label: howDoIRemovePaymentMethodLabel, isExpanded: isPaymentMethodsExpanded)
            
        } else if button == openAndCloseButton[3] {
            
            isViewMyChargingExpanded.toggle()
            
            howDoRefundWorkViewHeightConstraint.constant = isViewMyChargingExpanded ? expandedHeightViewMyCharging : collapsedHeight
            
            refundsAreProcessedAfterLabel.isHidden = !isViewMyChargingExpanded
            wasThisHelpfulLabel[3].isHidden = !isViewMyChargingExpanded
            likeButton[3].isHidden = !isViewMyChargingExpanded
            dislikeButton[3].isHidden = !isViewMyChargingExpanded
            lineView[3].isHidden = !isViewMyChargingExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[3],label: howDoRefundWorksLabel, isExpanded: isViewMyChargingExpanded)
            
        } else if button == openAndCloseButton[4] {
            
            isCanIReserveExpanded.toggle()
            
            howDoDownloadAnInvoiceViewHeightConstraint.constant = isCanIReserveExpanded ? expandedHeightCanIReserve : collapsedHeight
            
            openChargingHistoryOrTransactionLabel.isHidden = !isCanIReserveExpanded
            wasThisHelpfulLabel[4].isHidden = !isCanIReserveExpanded
            likeButton[4].isHidden = !isCanIReserveExpanded
            dislikeButton[4].isHidden = !isCanIReserveExpanded
            lineView[4].isHidden = !isCanIReserveExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[4],label: howDoIDownloadInvoiceLabel, isExpanded: isCanIReserveExpanded)
            
        } else if button == openAndCloseButton[5] {
            
            isChargingNotWorkExpanded.toggle()
            
            howLongDoesTakeViewHeightConstraint.constant = isChargingNotWorkExpanded ? expandedHeightChargingNotWork : collapsedHeight
            
            refundUsuallyTakesLabel.isHidden = !isChargingNotWorkExpanded
            wasThisHelpfulLabel[5].isHidden = !isChargingNotWorkExpanded
            likeButton[5].isHidden = !isChargingNotWorkExpanded
            dislikeButton[5].isHidden = !isChargingNotWorkExpanded
            lineView[5].isHidden = !isChargingNotWorkExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[5],label: howLongDoesItTakeToRefundLabel, isExpanded: isChargingNotWorkExpanded)
        } else if button == openAndCloseButton[6] {
            
            isChargingNotWorkExpanded.toggle()
            
            whyWasMyPaymentDeclinedViewHeightConstraint.constant = isChargingNotWorkExpanded ? expandedHeightChargingNotWork : collapsedHeight
            
            yourPaymentMaybeDeclinedLabel.isHidden = !isChargingNotWorkExpanded
            wasThisHelpfulLabel[6].isHidden = !isChargingNotWorkExpanded
            likeButton[6].isHidden = !isChargingNotWorkExpanded
            dislikeButton[6].isHidden = !isChargingNotWorkExpanded
            lineView[6].isHidden = !isChargingNotWorkExpanded
            
            updateExpandButtonUI(button: openAndCloseButton[6],label: whyWasMyPaymentDeclinedLabel, isExpanded: isChargingNotWorkExpanded)
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
    
    private func setInitialCollapsedState() {
        whatPaymentMethodViewHeightConstraint.constant = collapsedHeight
        howDoAddPaymentMethodViewHeightConstraint.constant = collapsedHeight
        howDoRemovePaymentMethodViewHeightConstraint.constant = collapsedHeight
        howDoRefundWorkViewHeightConstraint.constant = collapsedHeight
        howDoDownloadAnInvoiceViewHeightConstraint.constant = collapsedHeight
        howLongDoesTakeViewHeightConstraint.constant = collapsedHeight
        whyWasMyPaymentDeclinedViewHeightConstraint.constant = collapsedHeight

        weAcceptCreditCardLabel.isHidden = true
        goToProfilePaymentLabel.isHidden = true
        paymentMethodAndTapAddPaymentLabel.isHidden = true
        refundsAreProcessedAfterLabel.isHidden = true
        openChargingHistoryOrTransactionLabel.isHidden = true
        refundUsuallyTakesLabel.isHidden = true
        yourPaymentMaybeDeclinedLabel.isHidden = true
        
        whatPaymentMethodsLabel.textColor = .label
        howDoIAddPaymentMethodLabel.textColor = .label
        howDoIRemovePaymentMethodLabel.textColor = .label
        howDoRefundWorksLabel.textColor = .label
        howDoIDownloadInvoiceLabel.textColor = .label
        howLongDoesItTakeToRefundLabel.textColor = .label
        whyWasMyPaymentDeclinedLabel.textColor = .label
        
        for label in wasThisHelpfulLabel {
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

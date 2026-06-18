//
//  OTPVerificationVC.swift
//  EVSmartCity
//
//  Created by Hitman on 30/04/26.
//

enum VerificationSource {
    case login
    case signUp
}

import UIKit

class OTPVerificationVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var verifyYourNumberLabel: UILabel!
    @IBOutlet weak var weHaveSentFourDigitCodeLabel: UILabel!
    @IBOutlet var otpTF: [UITextField]!
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    
    var resendTimer: Timer?
    var totalTime = 30
    var resendTap: UITapGestureRecognizer?
    var mobileNumber: String = ""
    var rawMobileNumber: String = ""
    var countryCode: String?
    var isErrorState = false
    
    var source: VerificationSource = .login
    
    let dummyOTP = "999999"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopResendTimer()
    }
    
    deinit {
        stopResendTimer()
    }
        
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        var otpCode = ""
        for textField in otpTF {
            if let text = textField.text, !text.isEmpty {
                otpCode += text
            }
        }
        
        if otpCode.count == 6 {
            verifyOTP(mobileNumber: mobileNumber, otp: otpCode)
        } else {
            showErrorOnOTPFields("Please enter the complete 6-digit OTP")
        }
        
    }
}

extension OTPVerificationVC : UITextFieldDelegate {
    func setUpUI() {
        setupResendLabel()
        setupOTPTextFields()
        setupMobileNumberDisplay()
        startResendTimer()
        hideKeyboardWhenTappedAround()
    }
    
    func setupMobileNumberDisplay() {
        let formattedNumber = formatMobileNumberForDisplay()
        weHaveSentFourDigitCodeLabel.text = "We've sent a 6-digit code to your mobile number \n\(formattedNumber)"
    }
    
    func formatMobileNumberForDisplay() -> String {
        let countryCodeWithPlus = countryCode ?? ""
        let number = rawMobileNumber
        let maskedNumber = maskMobileNumber(number)
        let formattedNumber = "+\(countryCodeWithPlus) \(maskedNumber)"
        return formattedNumber
    }
    
    func maskMobileNumber(_ number: String) -> String {
        guard number.count >= 6 else { return number }
        
        let firstDigit = String(number.prefix(1))
        let lastThree = String(number.suffix(3))
        
        let asteriskCount = number.count - 4
        let asterisks = String(repeating: "x", count: asteriskCount)
        
        return "\(firstDigit)\(asterisks)\(lastThree)"
    }
    
    func setupOTPTextFields() {
        for (index, textField) in otpTF.enumerated() {
            textField.delegate = self
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 8
            textField.tag = index
            textField.clipsToBounds = true
            textField.backgroundColor = .clear
            textField.textColor = .label
            textField.tintColor = UIColor(hex: "#379D67")
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
        
    func startResendTimer() {
        stopResendTimer()
        totalTime = 30
        updateResendCountdownText()
        
        resendTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(updateTimer),userInfo: nil,
                                          repeats: true)
        RunLoop.main.add(resendTimer!, forMode: .common)
    }
    
    @objc func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            updateResendCountdownText()
        } else {
            stopResendTimer()
            enableResendButton()
        }
    }
    
    func stopResendTimer() {
        resendTimer?.invalidate()
        resendTimer = nil
    }
    
    func enableResendButton() {
        let staticText = "Didn’t receive code? "
        let resendText = "Resend"
        let fullText = staticText + resendText
        
        verifyButton.isUserInteractionEnabled = true
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.label,
                                      range: NSRange(location: 0, length: staticText.count))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13),
                                      range: NSRange(location: 0, length: staticText.count))
        
        if let resendRange = fullText.range(of: resendText) {
            let nsRange = NSRange(resendRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#379D67"),
                                          range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .semibold),
                                          range: nsRange)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                                          range: nsRange)
        }
        
        resendLabel.attributedText = attributedString
        resendLabel.isUserInteractionEnabled = true
        isErrorState = false
    }
    
    func updateResendCountdownText() {
        
        if isErrorState {
            return
        }
        
        let minutes = totalTime / 60
        let seconds = totalTime % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        
        let staticText = "Didn’t receive code? "
        let resendText = "Resend"
        let tailText = " — \(timeString)"
                
        let fullText = staticText + resendText + tailText
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.label,
                                      range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13),
                                      range: NSRange(location: 0, length: fullText.count))
        
        if let resendRange = fullText.range(of: resendText) {
            let nsRange = NSRange(resendRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#379D67"),
                                          range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .bold),
                                          range: nsRange)
        }
        
        if let tailRange = fullText.range(of: tailText) {
            let nsRange = NSRange(tailRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#379D67"),
                                          range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold),
                                          range: nsRange)
        }
        
        resendLabel.attributedText = attributedString
        resendLabel.isUserInteractionEnabled = false
    }
    
    func setupResendLabel() {
        resendLabel.isUserInteractionEnabled = true
        resendTap = UITapGestureRecognizer(target: self, action: #selector(resendTapped))
        resendLabel.addGestureRecognizer(resendTap!)
    }
    
    @objc func resendTapped() {
        let formattedNumber = formatMobileNumberForDisplay()
        let resendMessage = "Verification code has been resent to \(formattedNumber)"
        
        if resendTimer == nil || !resendTimer!.isValid {
            showLoading(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.showLoading(false)
                self?.showAlert(resendMessage)
                self?.startResendTimer()
            }
        }
    }
    
    func verifyOTP(mobileNumber: String, otp: String) {
        showLoading(true)
        
        if otp == dummyOTP {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.showLoading(false)
                self?.navigateToPhoneVerifiedScreen()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.showLoading(false)
                self?.isErrorState = true
                for tf in self?.otpTF ?? [] {
                    tf.layer.borderColor = UIColor.red.cgColor
                    tf.layer.borderWidth = 2
                    tf.backgroundColor = .clear
                    tf.textColor = .label
                    tf.tintColor = .clear
                }
                self?.resendLabel.text = "Incorrect code. Please try again."
                self?.resendLabel.textColor = .red
                self?.resendLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                self?.shakeOTPFields()
                self?.clearOTPFields()
                
                self?.view.endEditing(true)
            }
        }
    }
    
    func showErrorOnOTPFields(_ errorMessage: String) {
        isErrorState = true
        for textField in otpTF {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 2
            textField.backgroundColor = .clear
            textField.textColor = .label
            textField.tintColor = .clear
        }
        resendLabel.text = errorMessage
        resendLabel.textColor = UIColor.red
        resendLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        resendLabel.isUserInteractionEnabled = false
    }
    
    func resetOTPFieldsBorder() {
        isErrorState = false
        for textField in otpTF {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 1
            textField.backgroundColor = .clear
            textField.textColor = .label
            textField.tintColor = UIColor(hex: "#379D67")
        }
        updateOTPFieldUI()
    }
    
    func restoreResendLabel() {
        if resendTimer != nil && resendTimer!.isValid {
            updateResendCountdownText()
        } else {
            enableResendButton()
        }
        resendLabel.isUserInteractionEnabled = true
    }
        
    func navigateToPhoneVerifiedScreen() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneVerifiedVC") as! PhoneVerifiedVC
            let formattedNumber = formatMobileNumberForDisplay()
            vc.verifiedMobileNumber = formattedNumber
            vc.source = source
            if let sheet = vc.sheetPresentationController {
                vc.modalPresentationStyle = .pageSheet
                sheet.detents = [
                    .custom { context in
                        context.maximumDetentValue * 0.85
                    }
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
            }
            present(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneVerifiedVC") as! PhoneVerifiedVC
            let formattedNumber = formatMobileNumberForDisplay()
            vc.verifiedMobileNumber = formattedNumber
            vc.source = source
            if let sheet = vc.sheetPresentationController {
                vc.modalPresentationStyle = .pageSheet
                sheet.detents = [
                    .custom { context in
                        context.maximumDetentValue * 0.70
                    }
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
            }
            present(vc, animated: true)
        }
    }
    
    func clearOTPFields() {
        for textField in otpTF {
            textField.text = ""
            textField.backgroundColor = .clear
            textField.textColor = .label
        }
    }
    
    func shakeOTPFields() {
        for textField in otpTF {
            let shakeAnimation = CABasicAnimation(keyPath: "position")
            shakeAnimation.duration = 0.1
            shakeAnimation.repeatCount = 2
            shakeAnimation.autoreverses = true
            shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
            shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
            textField.layer.add(shakeAnimation, forKey: "position")
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showLoading(_ show: Bool) {
        verifyButton.isEnabled = !show
        if show {
            verifyButton.setTitle("Verifying...", for: .normal)
        } else {
            verifyButton.setTitle("Verify", for: .normal)
        }
    }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if otpTF.contains(textField) {
            // Clear error state when user starts typing
            if isErrorState {
                resetOTPFieldsBorder()
                restoreResendLabel()
            }
            
            if string.isEmpty {
                if let currentText = textField.text, !currentText.isEmpty {
                    textField.text = ""
                } else if textField.tag > 0 {
                    otpTF[textField.tag - 1].becomeFirstResponder()
                    otpTF[textField.tag - 1].text = ""
                }
                
                updateOTPFieldUI()
                return false
            }
            return (textField.text?.count ?? 0) < 1
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count >= 1 {
            textField.text = String(text.prefix(1))
            
            if textField.tag < otpTF.count - 1 {
                otpTF[textField.tag + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        updateOTPFieldUI()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if isErrorState {

            isErrorState = false

            // Restore resend label
            if resendTimer != nil && resendTimer!.isValid {
                updateResendCountdownText()
            } else {
                enableResendButton()
            }

            // Reset all OTP fields
            for tf in otpTF {
                tf.layer.borderColor = UIColor.lightGray.cgColor
                tf.layer.borderWidth = 1
                tf.tintColor = UIColor(hex: "#379D67")
            }
        }

        textField.layer.borderColor = UIColor(hex: "#379D67").cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !isErrorState {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 1
        }
    }
    
    func updateOTPFieldUI() {
        let greenColor = UIColor(hex: "#379D67")
        
        for textField in otpTF {
            // Don't change UI if there's an error
            if !isErrorState {
                if let text = textField.text, !text.isEmpty {
                    textField.backgroundColor = greenColor
                    textField.textColor = .white
                } else {
                    textField.backgroundColor = .clear
                    textField.textColor = .label
                }
            }
        }
    }
}

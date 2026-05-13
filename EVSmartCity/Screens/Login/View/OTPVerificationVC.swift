//
//  OTPVerificationVC.swift
//  EVSmartCity
//
//  Created by Hitman on 30/04/26.
//

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
    
    let dummyOTP = "9999"
    
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
        
        if otpCode.count == 4 {
            verifyOTP(mobileNumber: mobileNumber, otp: otpCode)
        } else {
            showAlert("Please enter the complete 4-digit OTP")
            shakeOTPFields()
        }
        
    }
}

extension OTPVerificationVC :  UITextFieldDelegate {
    func setUpUI() {
        setupResendLabel()
        setupOTPTextFields()
        setupMobileNumberDisplay()
        startResendTimer()
        hideKeyboardWhenTappedAround()
    }
    
    func setupMobileNumberDisplay() {
        let formattedNumber = formatMobileNumberForDisplay()
        weHaveSentFourDigitCodeLabel.text = "We've sent a 4-digit code to your mobile number \(formattedNumber)"
    }
    
    func formatMobileNumberForDisplay() -> String {
        let countryCodeWithPlus = countryCode ?? ""
        let number = rawMobileNumber
        let maskedNumber = maskMobileNumber(number)
        let formattedNumber = "+\(countryCodeWithPlus)\(maskedNumber)"
        
        return formattedNumber
    }
    
    func maskMobileNumber(_ number: String) -> String {
        guard number.count >= 6 else { return number }
        
        let firstDigit = String(number.prefix(1))
        let lastThree = String(number.suffix(3))
        
        let asteriskCount = number.count - 4
        let asterisks = String(repeating: "*", count: asteriskCount)
        
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
    }
    
    func updateResendCountdownText() {
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
                self?.navigateToLocationScreen()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.showLoading(false)
                self?.showAlert("Invalid OTP. Please try again. (Use: \(self?.dummyOTP ?? "9999"))")
                self?.clearOTPFields()
                self?.shakeOTPFields()
            }
        }
    }
        
    func navigateToLocationScreen() {
        let vc = UIStoryboard(name: "Location", bundle: nil)
            .instantiateViewController(withIdentifier: "SetLocationVC") as! SetLocationVC
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func clearOTPFields() {
        for textField in otpTF {
            textField.text = ""
        }
        otpTF.first?.becomeFirstResponder()
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
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
    }
    
    func updateOTPFieldUI() {
        let greenColor = UIColor(hex: "#379D67")
        let defaultColor = UIColor.clear
        
        for (index, textField) in otpTF.enumerated() {
            
            if let text = textField.text, !text.isEmpty {
                textField.backgroundColor = greenColor
                textField.textColor = .white
            } else {
                textField.backgroundColor = defaultColor
                textField.textColor = .label
            }
        }
    }
}

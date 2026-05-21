//
//  LoginViewController.swift
//  EVSmartCity
//  Created by ToqSoft on 01/12/25.

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var engLanguageButton: UIButton!
    @IBOutlet weak var arabicLanguageButton: UIButton!
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var loginToFindEVChargersLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var enterMobileNumberTF: UITextField!
    @IBOutlet weak var weWillSendYouOTPLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var continueWithAppleButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    var countryCodeList : [CountryModel] = []
    var selectedCountryName : String?
    var selectedCountryFlag : String?
    var maxMobileNumberLength: Int = 10
    var countryCode : String?
    var viewModel = CountryViewModel()
    var originalOTPMessage: String?
    
    let dummyMobileNumber = "987654321"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
//    @IBAction func englishButtonAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "LeftMenu", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
//        storyboard.modalPresentationStyle = .overFullScreen
//        self.present(storyboard, animated: true)
//    }
    
    @IBAction func englishButtonAction(_ sender: Any) {

        let vc = UIStoryboard(name: "LeftMenu", bundle: nil)
            .instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC

        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        view.window?.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false)
    }
    
    @IBAction func arabicButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Biometric", bundle: nil).instantiateViewController(withIdentifier: "BiometricLoginVC") as! BiometricLoginVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func selectCountryCodeButtonAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else { return }
        vc.countryList = countryCodeList
        vc.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.modalPresentationStyle = .formSheet
            vc.preferredContentSize = CGSize(
                width: UIScreen.main.bounds.width * 0.75,
                height: UIScreen.main.bounds.height * 0.6
            )
        } else {
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
        }
        present(vc, animated: true)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let mobileNumber = enterMobileNumberTF.text, !mobileNumber.isEmpty else {
            showInvalidNumberMessage()
            return
        }
        
        guard isValidMobileNumber(mobileNumber) else {
            showInvalidNumberMessage()
            return
        }
        
        if mobileNumber != dummyMobileNumber {
            showDummyNumberAlert()
            return
        }
        
        let fullMobileNumber = (countryCode ?? "") + mobileNumber
        navigateToOTPVerification(mobileNumber: fullMobileNumber, rawMobileNumber: mobileNumber)
    }
    
    @IBAction func continueWithAppleButtonAction(_ sender: Any) {
        print("Continue with Apple button tapped")
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
}

extension LoginViewController : SelectCountryDelegate {
    
    func didSelectCountry(_ country: CountryModel) {
        countryCodeButton.setTitle("\(country.flag) \(country.code)", for: .normal)
        selectedCountryFlag = country.flag
        selectedCountryName = country.name
        maxMobileNumberLength = country.max_length
        countryCode = String(country.code.dropFirst())
        enterMobileNumberTF.text = ""
        resetOTPLabel()
    }
    
    func setUpUI() {
        hideKeyboardWhenTappedAround()
        originalOTPMessage = weWillSendYouOTPLabel.text
        
        viewModel.loadCountries { countryName in
            self.countryCodeList = countryName
            
            if let saudi = countryName.first(where: { $0.name.lowercased() == "saudi arabia" }) {
                self.didSelectCountry(saudi)
            } else if let firstCountry = countryName.first {
                self.didSelectCountry(firstCountry)
            }
        }
        
        enterMobileNumberTF.delegate = self
    }
    
    func navigateToOTPVerification(mobileNumber: String, rawMobileNumber: String) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let otpVC = storyboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as? OTPVerificationVC else {
            return
        }
        otpVC.mobileNumber = mobileNumber
        otpVC.rawMobileNumber = rawMobileNumber
        otpVC.countryCode = self.countryCode
        otpVC.modalPresentationStyle = .fullScreen
        present(otpVC, animated: true)
    }
    
    func isValidMobileNumber(_ number: String) -> Bool {
        let cleanedNumber = number.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedNumber.count != maxMobileNumberLength {
            return false
        }
        
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cleanedNumber)) else {
            return false
        }
        
        if Set(cleanedNumber).count == 1 {
            return false
        }
        
        if cleanedNumber.first == "0" {
            return false
        }
        
        return true
    }
    
    func showInvalidNumberMessage() {
        weWillSendYouOTPLabel.text = "⚠️ Please enter a valid \(maxMobileNumberLength)-digit mobile number"
        weWillSendYouOTPLabel.textColor = .red
        
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: enterMobileNumberTF.center.x - 5, y: enterMobileNumberTF.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: enterMobileNumberTF.center.x + 5, y: enterMobileNumberTF.center.y))
        enterMobileNumberTF.layer.add(shakeAnimation, forKey: "position")
    }
    
    func showDummyNumberAlert() {
        let alert = UIAlertController(
            title: "Invalid Number",
            message: "Please enter the registered mobile number",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func resetOTPLabel() {
        weWillSendYouOTPLabel.text = originalOTPMessage
        weWillSendYouOTPLabel.textColor = .black
    }
}

extension LoginViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        if updatedText.count > maxMobileNumberLength {
            return false
        }
        
        if string.isEmpty {
            return true
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        resetOTPLabel()
    }
}

//
//  SignUpVC.swift
//  EVSmartCity
//
//  Created by Hitman on 29/04/26.

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var englishlanguageButton: UIButton!
    @IBOutlet weak var arabicLanguageButton: UIButton!
    @IBOutlet weak var startYourEVChargingLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var enterFullnameTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var enterYourEmailTF: UITextField!
    @IBOutlet weak var selectCheckMarkButton: UIButton!
    @IBOutlet weak var iAgreeTermsAndPrivacyLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var selectCountryCodeButton: UIButton!
    @IBOutlet weak var enterMobileNumberTF: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryFlagButtonAction: UIButton!
    @IBOutlet weak var enterCountryNameTF: UITextField!
    
    var countryCodeList : [CountryModel] = []
    var selectedCountryName : String?
    var selectedCountryFlag : String?
    var maxMobileNumberLength: Int = 10
    var countryCode : String?
    var viewModel = CountryViewModel()
    
    private var isCreatePasswordSecure = true
    private var isConfirmPasswordSecure = true
    private var isCheckmarkSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        viewModel.loadCountries { countryName in
            self.countryCodeList = countryName
            
            if let saudi = countryName.first(where: { $0.name.lowercased() == "saudi arabia" }) {
                self.didSelectCountry(saudi)
            } else if let firstCountry = countryName.first {
                self.didSelectCountry(firstCountry)
            }
        }
        setupInitialStates()
    }
    
    private func setupInitialStates() {
        let squareImage = UIImage(systemName: "square")
        selectCheckMarkButton.setImage(squareImage, for: .normal)
        selectCheckMarkButton.tintColor = .systemBlue
    }
    
    @IBAction func englishLanguageButtonAction(_ sender: Any) {
    }
    
    @IBAction func arabicLanguageButtonAction(_ sender: Any) {
    }
    
    @IBAction func selectCountryCodeButtonAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as? SelectCountryViewController else{ return }
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
    
    @IBAction func countryFlagButtonAction(_ sender: Any) {
    }
    
    @IBAction func selectCheckmarkButtonAction(_ sender: Any) {
        isCheckmarkSelected.toggle()
        
        let imageName = isCheckmarkSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)
        selectCheckMarkButton.setImage(image, for: .normal)
        
        selectCheckMarkButton.tintColor = isCheckmarkSelected ? .systemGreen : .label
    }
    
    @IBAction func createAccountButtonAction(_ sender: Any) {
        guard let fullname = enterFullnameTF.text, !fullname.isEmpty else {
            showAlert(message: "Please enter your full name")
            return
        }
        
        guard let email = enterYourEmailTF.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address")
            return
        }
        
        guard isCheckmarkSelected else {
            showAlert(message: "Please agree to the Terms and Privacy Policy")
            return
        }
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error",
                                    message: message,
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension SignUpVC : SelectCountryDelegate {
    func didSelectCountry(_ country: CountryModel) {
        selectCountryCodeButton.setTitle("\(country.flag) \(country.code)", for: .normal)
        selectedCountryFlag = country.flag
        selectedCountryName = country.name
        maxMobileNumberLength = country.max_length
        countryCode = String(country.code.dropFirst())
        
        enterMobileNumberTF.text = ""
    }
}

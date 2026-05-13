//
//  EnterYourPasscodeVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/05/26.
/*
import UIKit

class EnterYourPasscodeVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fingerPrintVerificationTitleLabel: UILabel!
    @IBOutlet weak var enterPasscodeLabel: UILabel!
    @IBOutlet weak var entersixDigitPasscodeLabel: UILabel!
    @IBOutlet var passcodeTF: [UITextField]!
    @IBOutlet weak var numberPadView: UIView!
    @IBOutlet weak var secureAndPrivateLabel: UILabel!
    @IBOutlet weak var yourDataIsEncryptedLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var enteredPasscode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPasscodeFields()
        setupNumberPad()
        // Set initial text
        entersixDigitPasscodeLabel.text = "Enter your 6-digit passcode to continue"
        entersixDigitPasscodeLabel.textColor = .black
    }

    // MARK: - Setup Passcode Fields

    func setupPasscodeFields() {
        let cornerRadius: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12.5 : 8
        passcodeTF.forEach {
            $0.layer.cornerRadius = cornerRadius
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hex: "#379D67").cgColor
            $0.textAlignment = .center
            $0.isUserInteractionEnabled = false
            $0.keyboardType = .numberPad
            $0.text = ""
        }
    }

    // MARK: - Setup Number Pad

    func setupNumberPad() {
        let numbers = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "delete.left"]
        ]

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        numberPadView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: numberPadView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: numberPadView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: numberPadView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: numberPadView.bottomAnchor)
        ])

        for row in numbers {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 20
            rowStack.distribution = .fillEqually
            for item in row {
                if item == "" {
                    let emptyView = UIView()
                    rowStack.addArrangedSubview(emptyView)
                } else {
                    let button = UIButton(type: .system)
                    if item == "delete.left" {
                        let image = UIImage(systemName: "delete.left")
                        button.setImage(image, for: .normal)
                        button.tintColor = .black
                        button.tag = -1
                    } else {
                        button.setTitle(item, for: .normal)
                        button.setTitleColor(.black, for: .normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .medium)
                        button.tag = Int(item) ?? 0
                    }
                    button.backgroundColor = .white
                    button.layer.cornerRadius = 35
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.systemGray5.cgColor
                    button.clipsToBounds = true
                    button.heightAnchor.constraint(equalToConstant: 70).isActive = true
                    button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
                    rowStack.addArrangedSubview(button)
                }
            }
            mainStack.addArrangedSubview(rowStack)
        }
    }

    // MARK: - Number Button Action

    @objc func numberButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor(hex: "#379D67")
        if sender.tag != -1 {
            sender.setTitleColor(.white, for: .normal)
        } else {
            sender.tintColor = .white
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            sender.backgroundColor = .white
            if sender.tag != -1 {
                sender.setTitleColor(.black, for: .normal)
            } else {
                sender.tintColor = .black
            }
        }
        
        // Reset error message when user starts typing again
        if entersixDigitPasscodeLabel.text != "Enter your 6-digit passcode to continue" {
            resetErrorMessage()
        }
        
        if sender.tag == -1 {
            if !enteredPasscode.isEmpty {
                enteredPasscode.removeLast()
            }
        } else {
            if enteredPasscode.count < 6 {
                enteredPasscode += "\(sender.tag)"
            }
        }
        updatePasscodeUI()
    }

    // MARK: - Update UI

    func updatePasscodeUI() {
        for (index, textField) in passcodeTF.enumerated() {
            if index < enteredPasscode.count {
                textField.backgroundColor = UIColor(hex: "#379D67")
                textField.text = ""
            } else {
                textField.backgroundColor = .white
                textField.text = ""
            }
        }

        // Check Passcode
        if enteredPasscode.count == 6 {
            if enteredPasscode == "123456" {
                print("Correct Passcode")
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            } else {
                print("Wrong Passcode")
                showWrongPasscodeError()
                enteredPasscode = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.passcodeTF.forEach {
                        $0.backgroundColor = .white
                    }
                }
            }
        }
    }
    
    // MARK: - Show Wrong Passcode Error
    
    func showWrongPasscodeError() {
        // Change the label text to error message
        entersixDigitPasscodeLabel.text = "Enter correct 6-digit passcode"
        entersixDigitPasscodeLabel.textColor = .red
        
        // Add shake animation to the passcode fields
        animateShakeToPasscodeFields()
    }
    
    func resetErrorMessage() {
        entersixDigitPasscodeLabel.text = "Enter your 6-digit passcode to continue"
        entersixDigitPasscodeLabel.textColor = UIColor(hex: "757575")
    }
    
    func animateShakeToPasscodeFields() {
        for textField in passcodeTF {
            let shakeAnimation = CABasicAnimation(keyPath: "position")
            shakeAnimation.duration = 0.07
            shakeAnimation.repeatCount = 3
            shakeAnimation.autoreverses = true
            shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 8, y: textField.center.y))
            shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 8, y: textField.center.y))
            textField.layer.add(shakeAnimation, forKey: "shake")
        }
        
        // Optional: Add haptic feedback on wrong passcode
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    // MARK: - Back Button

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
    }
    
}
*/

import UIKit

class EnterYourPasscodeVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fingerPrintVerificationTitleLabel: UILabel!
    @IBOutlet weak var enterPasscodeLabel: UILabel!
    @IBOutlet weak var entersixDigitPasscodeLabel: UILabel!
    @IBOutlet var passcodeTF: [UITextField]!
    @IBOutlet weak var numberPadView: UIView!
    @IBOutlet weak var secureAndPrivateLabel: UILabel!
    @IBOutlet weak var yourDataIsEncryptedLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var enteredPasscode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPasscodeFields()
        setupNumberPad()
        
        entersixDigitPasscodeLabel.text = "Enter your 6-digit passcode to continue"
        entersixDigitPasscodeLabel.textColor = .black
        
        setupForgotPasswordButton()
    }
    
    // MARK: - Setup Forgot Password Button
    
    func setupForgotPasswordButton() {
        forgotPasswordButton.isHidden = true
    }

    // MARK: - Setup Passcode Fields

    func setupPasscodeFields() {
        let cornerRadius: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12.5 : 8
        passcodeTF.forEach {
            $0.layer.cornerRadius = cornerRadius
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hex: "#379D67").cgColor
            $0.textAlignment = .center
            $0.isUserInteractionEnabled = false
            $0.keyboardType = .numberPad
            $0.text = ""
        }
    }

    // MARK: - Setup Number Pad

    func setupNumberPad() {
        let numbers = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "delete.left"]
        ]

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        numberPadView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: numberPadView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: numberPadView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: numberPadView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: numberPadView.bottomAnchor)
        ])

        for row in numbers {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 20
            rowStack.distribution = .fillEqually
            for item in row {
                if item == "" {
                    let emptyView = UIView()
                    rowStack.addArrangedSubview(emptyView)
                } else {
                    let button = UIButton(type: .system)
                    if item == "delete.left" {
                        let image = UIImage(systemName: "delete.left")
                        button.setImage(image, for: .normal)
                        button.tintColor = .black
                        button.tag = -1
                    } else {
                        button.setTitle(item, for: .normal)
                        button.setTitleColor(.black, for: .normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .medium)
                        button.tag = Int(item) ?? 0
                    }
                    button.backgroundColor = .white
                    button.layer.cornerRadius = 35
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.systemGray5.cgColor
                    button.clipsToBounds = true
                    button.heightAnchor.constraint(equalToConstant: 70).isActive = true
                    button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
                    rowStack.addArrangedSubview(button)
                }
            }
            mainStack.addArrangedSubview(rowStack)
        }
    }

    // MARK: - Number Button Action

    @objc func numberButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor(hex: "#379D67")
        if sender.tag != -1 {
            sender.setTitleColor(.white, for: .normal)
        } else {
            sender.tintColor = .white
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            sender.backgroundColor = .white
            if sender.tag != -1 {
                sender.setTitleColor(.black, for: .normal)
            } else {
                sender.tintColor = .black
            }
        }
        
        if entersixDigitPasscodeLabel.text != "Enter your 6-digit passcode to continue" {
            resetErrorMessage()
        }
        
        if sender.tag == -1 {
            if !enteredPasscode.isEmpty {
                enteredPasscode.removeLast()
            }
        } else {
            if enteredPasscode.count < 6 {
                enteredPasscode += "\(sender.tag)"
            }
        }
        updatePasscodeUI()
    }

    // MARK: - Update UI

    func updatePasscodeUI() {
        for (index, textField) in passcodeTF.enumerated() {
            if index < enteredPasscode.count {
                textField.backgroundColor = UIColor(hex: "#379D67")
                textField.text = ""
            } else {
                textField.backgroundColor = .white
                textField.text = ""
            }
        }

        // Check Passcode
        if enteredPasscode.count == 6 {
            if enteredPasscode == "123456" {
                print("Correct Passcode")
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            } else {
                print("Wrong Passcode")
                showWrongPasscodeError()
                enteredPasscode = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.passcodeTF.forEach {
                        $0.backgroundColor = .white
                    }
                }
            }
        }
    }
    
    // MARK: - Show Wrong Passcode Error
    
    func showWrongPasscodeError() {
        entersixDigitPasscodeLabel.text = "Enter correct 6-digit passcode"
        entersixDigitPasscodeLabel.textColor = .red
        showForgotPasswordButton()
        
        animateShakeToPasscodeFields()
    }
    
    func resetErrorMessage() {
        entersixDigitPasscodeLabel.text = "Enter your 6-digit passcode to continue"
        entersixDigitPasscodeLabel.textColor = UIColor(hex: "757575")
    }
    
    func animateShakeToPasscodeFields() {
        for textField in passcodeTF {
            let shakeAnimation = CABasicAnimation(keyPath: "position")
            shakeAnimation.duration = 0.07
            shakeAnimation.repeatCount = 3
            shakeAnimation.autoreverses = true
            shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 8, y: textField.center.y))
            shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 8, y: textField.center.y))
            textField.layer.add(shakeAnimation, forKey: "shake")
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    // MARK: - Forgot Password Button Visibility
    
    func showForgotPasswordButton() {
        if forgotPasswordButton.isHidden {
            forgotPasswordButton.isHidden = false
            
            // Optional: Add fade-in animation
            forgotPasswordButton.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.forgotPasswordButton.alpha = 1
            }
        }
    }
    
    func hideForgotPasswordButton() {
        forgotPasswordButton.isHidden = true
    }

    // MARK: - Back Button

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ChangePasscodeVC") as! ChangePasscodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

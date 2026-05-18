//
//  ChangePasscodeVC.swift
//  EVSmartCity
//
//  Created by Hitman on 11/05/26.

import UIKit

class ChangePasscodeVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var changePasscodeLabel: UILabel!
    @IBOutlet weak var keepYourAccountSecureLabel: UILabel!
    @IBOutlet weak var chooseSecurePasswordLabel: UILabel!
    @IBOutlet weak var enterNewPasswordTF: UITextField!
    @IBOutlet weak var newPasswordEyeButton: UIButton!
    @IBOutlet weak var retypePasswordTF: UITextField!
    @IBOutlet weak var reTypePasswordEyeButton: UIButton!
    @IBOutlet weak var passcodeRequirementLabel: UILabel!
    @IBOutlet weak var oneUppercaseLetter: UILabel!
    @IBOutlet weak var oneNumberLabel: UILabel!
    @IBOutlet weak var eightCharactersLabel: UILabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var retypePasswordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterNewPasswordTF.isSecureTextEntry = true
        retypePasswordTF.isSecureTextEntry = true
        
        setEyeButtonImage(button: newPasswordEyeButton, isSecure: true)
        setEyeButtonImage(button: reTypePasswordEyeButton, isSecure: true)
        
        enterNewPasswordTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        retypePasswordTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        setupViewBorder(view: newPasswordView)
        setupViewBorder(view: retypePasswordView)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newPassowrdEyeButtonAction(_ sender: Any) {
        togglePasswordVisibility(textField: enterNewPasswordTF, button: newPasswordEyeButton)
    }
    
    @IBAction func retypePasswordEyeButtonAction(_ sender: Any) {
        togglePasswordVisibility(textField: retypePasswordTF, button: reTypePasswordEyeButton)
    }
    
    @IBAction func changePasswordButtonAction(_ sender: Any) {
        guard let newPassword = enterNewPasswordTF.text, !newPassword.isEmpty else {
            showAlert(message: "Please enter a new password")
            return
        }
        
        guard let retypedPassword = retypePasswordTF.text, !retypedPassword.isEmpty else {
            showAlert(message: "Please retype your password")
            return
        }
        
        guard newPassword == retypedPassword else {
            showMismatchError()
            showAlert(message: "Passwords do not match")
            return
        }
        
        clearMismatchError()
        showAlert(message: "Password changed successfully!")
    }
    
    @objc private func textFieldsDidChange() {
        if let newPassword = enterNewPasswordTF.text,
           let retypedPassword = retypePasswordTF.text,
           !retypedPassword.isEmpty {
            if newPassword != retypedPassword {
                showMismatchError()
            } else {
                clearMismatchError()
            }
        } else {
            clearMismatchError()
        }
    }
    
    private func setupViewBorder(view: UIView) {
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 8
    }
    
    private func showMismatchError() {
        retypePasswordView.layer.borderWidth = 0.5
        retypePasswordView.layer.borderColor = UIColor.red.cgColor
    }
    
    private func clearMismatchError() {
        retypePasswordView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func togglePasswordVisibility(textField: UITextField, button: UIButton) {
        textField.isSecureTextEntry.toggle()
        setEyeButtonImage(button: button, isSecure: textField.isSecureTextEntry)
    }
    
    private func setEyeButtonImage(button: UIButton, isSecure: Bool) {
        let imageName = isSecure ? "eye.slash.fill" : "eye.fill"
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
        button.tintColor = .gray
    }

}

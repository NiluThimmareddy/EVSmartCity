//
//  EnterVehicleDetails.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit

class EnterVehicleDetails: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectYourModelTitleLabel: UILabel!
    @IBOutlet weak var step3of4Label: UILabel!
    @IBOutlet weak var enterYourVehicleDetailsLavel: UILabel!
    @IBOutlet weak var addYourRegisteredNumberLabel: UILabel!
    @IBOutlet weak var licensePlateNumberLabel: UILabel!
    @IBOutlet weak var whyDoWeNeedThisLabel: UILabel!
    @IBOutlet weak var toHelpYouFindLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var charactersCountLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var licensePlateView: UIView!
    @IBOutlet weak var saLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var stateCodeTF: UITextField!
    @IBOutlet weak var licencePlateNumTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        nickNameTextField.delegate = self
        charactersCountLabel.text = "0/20"
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ReviewAndConfirmVC") as! ReviewAndConfirmVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func stateNameButtonAction(_ sender: Any) {
    }
    
}

extension EnterVehicleDetails: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if updatedText.count > 20 {
            return false
        }
        charactersCountLabel.text = "\(updatedText.count)/20"
        return true
    }
}

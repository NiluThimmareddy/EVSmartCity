//
//  EnterVehicleDetails.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit

class EnterVehicleDetails: UIViewController,UIColorPickerViewControllerDelegate {
    
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
    @IBOutlet weak var vehicleColorLabel: UILabel!
    @IBOutlet var optionalLabel: [UILabel]!
    @IBOutlet weak var vehicleColorCollectionView: UICollectionView!
    @IBOutlet weak var vehiclePhotoLabel: UILabel!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var uploadImgButton: UIButton!
    @IBOutlet weak var uploadedImgView: UIImageView!
    
    var selectedColorIndex: Int? = nil
    var customSelectedColor: UIColor?
    var selectedVehicleImage: UIImage?
    
    var vehicleColour: [VehicleColour] = [
        VehicleColour(color: UIColor(hex: "#0A1F1A"), isAddButton: false),
        VehicleColour(color: .white, isAddButton: false),
        VehicleColour(color: .red, isAddButton: false),
        VehicleColour(color: .systemBlue, isAddButton: false),
        VehicleColour(color: .lightGray, isAddButton: false),
        VehicleColour(color: nil, isAddButton: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "VehicleAddedSuccessfullyVC") as! VehicleAddedSuccessfullyVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func stateNameButtonAction(_ sender: Any) {
    }
    
    @IBAction func uploadImgButtonAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

extension EnterVehicleDetails : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicleColour.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleColorCVC", for: indexPath) as! VehicleColorCVC
        let colour = vehicleColour[indexPath.row]
        
        if colour.isAddButton {
            cell.colourView.backgroundColor = .clear
            cell.colourView.layer.borderWidth = 1
            cell.colourView.layer.borderColor = UIColor.lightGray.cgColor
            cell.colourView.layer.cornerRadius = 20
            cell.plusLabel.isHidden = false
            cell.plusLabel.text = "+"
            cell.plusLabel.textColor = .lightGray
            cell.plusLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        } else {
            cell.colourView.backgroundColor = colour.color
            cell.colourView.layer.borderWidth = 0
            cell.plusLabel.isHidden = true
            if colour.color == .white {
                cell.colourView.layer.borderWidth = 1
                cell.colourView.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        
        if selectedColorIndex == indexPath.row {
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor(hex: "#379D67").cgColor
            cell.layer.cornerRadius = 20
        } else {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize: CGFloat = 40
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colour = vehicleColour[indexPath.row]
        if colour.isAddButton {
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            colorPicker.selectedColor = .systemBlue
            present(colorPicker, animated: true)
            return
        }
        selectedColorIndex = indexPath.row
        vehicleColorCollectionView.reloadData()
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

extension EnterVehicleDetails: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            selectedVehicleImage = image
            
            uploadImgButton.setTitle("Photo Selected ✓", for: .normal)
            
            if uploadedImgView != nil {
                uploadedImgView.image = image
                uploadedImgView.isHidden = false
                uploadedImgView.contentMode = .scaleAspectFill
                uploadedImgView.layer.cornerRadius = 8
                uploadedImgView.clipsToBounds = true
            }
            uploadImgButton.setImage(image.resized(to: CGSize(width: 30, height: 30)), for: .normal)
            uploadImgButton.imageView?.contentMode = .scaleAspectFit
            uploadImgButton.tintColor = .clear
            
            uploadImgButton.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.2)
            uploadImgButton.setTitleColor(UIColor(hex: "#379D67"), for: .normal)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension EnterVehicleDetails {
    func setUpUI() {
        hideKeyboardWhenTappedAround()
        nickNameTextField.delegate = self
        charactersCountLabel.text = "0/20"
        
        vehicleColorCollectionView.register(UINib(nibName: "VehicleColorCVC", bundle: nil), forCellWithReuseIdentifier: "VehicleColorCVC")
        if let colourLayouts = vehicleColorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            colourLayouts.estimatedItemSize = .zero
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        customSelectedColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        vehicleColour.insert(
            VehicleColour(color: selectedColor, isAddButton: false),
            at: vehicleColour.count - 1
        )
        selectedColorIndex = vehicleColour.count - 2
        vehicleColorCollectionView.reloadData()
    }
    
}

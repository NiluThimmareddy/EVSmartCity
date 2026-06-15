//
//  AddAnotherVechileVC.swift
//  EVSmartCity
//
//  Created by Hitman on 11/05/26.

import UIKit

class AddAnotherVechileVC: UIViewController, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addVehicalLabel: UILabel!
    @IBOutlet weak var vehicleBrandLabel: UILabel!
    @IBOutlet weak var vehicleBrandCollectionView: UICollectionView!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var vehicleModelButton: UIButton!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var connectorTypeCollectionView: UICollectionView!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var stateArabicLabel: UILabel!
    @IBOutlet weak var stateEnglishTF: UITextField!
    @IBOutlet weak var vehicleNumbArabicLabel: UILabel!
    @IBOutlet weak var vehicleNumberEngLabel: UITextField!
    @IBOutlet weak var vehicleColourLabel: UILabel!
    @IBOutlet weak var optionalLabel: UILabel!
    @IBOutlet weak var vehicleColourCollectionView: UICollectionView!
    @IBOutlet weak var vehiclePhotoLabel: UILabel!
    @IBOutlet weak var photoOptionalLabel: UILabel!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var saveVehicleButton: UIButton!
    @IBOutlet weak var selectedPhotoImageView: UIImageView!
    
    var isEditMode = false
    var selectedVehicleImage: UIImage?
    
    var selectedBrandIndex: Int? = nil
    var selectedConnectorIndex: Int? = nil
    var selectedColorIndex: Int? = nil
    var selectedVehicleModel: String = ""
    var selectedBrandName: String = ""
    
    var customSelectedColor: UIColor?
    
    var vehicleDetails = [
        VehicleBrandModel(brandImage: "", brandname: "LUCID", brandDescription: "Air"),
        VehicleBrandModel(brandImage: "", brandname: "Tesla",brandDescription: "Model 3"),
        VehicleBrandModel(brandImage: "", brandname: "PORSCHE",brandDescription: "Taycan"),
        VehicleBrandModel(brandImage: "", brandname: "BYD",brandDescription: "Seal"),
        VehicleBrandModel(brandImage: "", brandname: "HYUNDAI",brandDescription: "Ioniq"),
        VehicleBrandModel(brandImage: "square.grid.2x2.fill", brandname: "Other",brandDescription: "")
    ]
    
    var connectorType = [
        ConnectorTypes(connectorTypeImg: "ic_typeConnector", connectorName: "Type 2", chargingType: "AC Standard"),
        ConnectorTypes(connectorTypeImg: "ic_typeConnector", connectorName: "CCS 2", chargingType: "DC Fast"),
        ConnectorTypes(connectorTypeImg: "ic_typeConnector", connectorName: "CHAdeMO", chargingType: "Legacy DC")
    ]
    
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
    
    // MARK: - IBActions
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadPhotoButtonAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func saveVehicleButtonAction(_ sender: Any) {
        guard selectedBrandIndex != nil else {
            showAlert(message: "Please select a vehicle brand")
            return
        }
        guard !selectedVehicleModel.isEmpty else {
            showAlert(message: "Please select a vehicle model")
            return
        }
        guard selectedConnectorIndex != nil else {
            showAlert(message: "Please select a connector type")
            return
        }
        guard selectedColorIndex != nil else {
            showAlert(message: "Please select a vehicle color")
            return
        }
        showAlert(message: "Vehicle saved successfully!")
    }

    func navigateToAddYourVehicleVC() {
        let addYourVehicleVC = storyboard?.instantiateViewController(withIdentifier: "AddYourVehicleVC") as! AddYourVehicleVC
        addYourVehicleVC.modalPresentationStyle = .fullScreen
        present(addYourVehicleVC, animated: true)
        
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddAnotherVechileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            selectedVehicleImage = image
            
            uploadPhotoButton.setTitle("Photo Selected ✓", for: .normal)
            
            if selectedPhotoImageView != nil {
                selectedPhotoImageView.image = image
                selectedPhotoImageView.isHidden = false
                selectedPhotoImageView.contentMode = .scaleAspectFill
                selectedPhotoImageView.layer.cornerRadius = 8
                selectedPhotoImageView.clipsToBounds = true
            }
            uploadPhotoButton.setImage(image.resized(to: CGSize(width: 30, height: 30)), for: .normal)
            uploadPhotoButton.imageView?.contentMode = .scaleAspectFit
            uploadPhotoButton.tintColor = .clear
            
            uploadPhotoButton.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.2)
            uploadPhotoButton.setTitleColor(UIColor(hex: "#379D67"), for: .normal)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension AddAnotherVechileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == vehicleBrandCollectionView {
            return vehicleDetails.count
        } else if collectionView == connectorTypeCollectionView {
            return connectorType.count
        } else if collectionView == vehicleColourCollectionView {
            return vehicleColour.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == vehicleBrandCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleBrandCVC", for: indexPath) as! VehicleBrandCVC
            let vehicle = vehicleDetails[indexPath.row]
            cell.vehicleNameLabel.text = vehicle.brandname
            cell.vehicleNameDescriptionLabel.text = vehicle.brandDescription
            cell.colourView.isHidden = true
            
            if selectedBrandIndex == indexPath.row {
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor(hex: "#379D67").cgColor
                cell.layer.cornerRadius = 8
                cell.colourView.isHidden = false
                cell.colourView.backgroundColor = UIColor(hex: "#379D67")
                cell.colourView.layer.cornerRadius = cell.colourView.frame.height / 2
            } else {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = nil
                cell.colourView.isHidden = true
            }
            return cell
        } else if collectionView == connectorTypeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectorTypeCVC", for: indexPath) as! ConnectorTypeCVC
            let connector = connectorType[indexPath.row]
            cell.connectorTypeImgView.image = UIImage(named: connector.connectorTypeImg)
            cell.connectorTypeName.text = connector.connectorName
            cell.chargingTypeLabel.text = connector.chargingType
            
            if selectedConnectorIndex == indexPath.row {
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor(hex: "#379D67").cgColor
                cell.layer.cornerRadius = 8
            } else {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = nil
            }
            return cell
        } else if collectionView == vehicleColourCollectionView {
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleBrandCVC", for: indexPath) as! VehicleBrandCVC
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == vehicleBrandCollectionView {
            let spacing: CGFloat = 12
            let totalSpacing = spacing * 2
            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / 3
            let itemHeight: CGFloat = 76
            return CGSize(width: itemWidth, height: itemHeight)
        } else if collectionView == connectorTypeCollectionView {
            let spacing: CGFloat = 12
            let totalSpacing = spacing * 2
            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / 3
            let itemHeight: CGFloat = 100
            return CGSize(width: itemWidth, height: itemHeight)
        } else if collectionView == vehicleColourCollectionView {
            let itemSize: CGFloat = 40
            return CGSize(width: itemSize, height: itemSize)
        } else {
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == vehicleBrandCollectionView {
            if indexPath.row == 5 {
                navigateToAddYourVehicleVC()
                return
            }
            selectedBrandIndex = indexPath.row
            selectedBrandName = vehicleDetails[indexPath.row].brandname
            vehicleModelButton.setTitle("Select \(selectedBrandName) Model", for: .normal)
            selectedVehicleModel = ""
            vehicleBrandCollectionView.reloadData()
        } else if collectionView == connectorTypeCollectionView {
            selectedConnectorIndex = indexPath.row
            connectorTypeCollectionView.reloadData()
        } else if collectionView == vehicleColourCollectionView {
            
            let colour = vehicleColour[indexPath.row]

            if colour.isAddButton {

                let colorPicker = UIColorPickerViewController()
                colorPicker.delegate = self
                colorPicker.selectedColor = .systemBlue
                present(colorPicker, animated: true)

                return
            }

            selectedColorIndex = indexPath.row
            vehicleColourCollectionView.reloadData()
        }
    }
}

extension AddAnotherVechileVC {
    func setUpUI() {
        if isEditMode {
            addVehicalLabel.text = "Edit Vehicle Details"
        } else {
            addVehicalLabel.text = "Add New Vehicle"
        }
        
        selectedPhotoImageView?.isHidden = true
        
        vehicleBrandCollectionView.register(UINib(nibName: "VehicleBrandCVC", bundle: nil), forCellWithReuseIdentifier: "VehicleBrandCVC")
        if let layout = vehicleBrandCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        connectorTypeCollectionView.register(UINib(nibName: "ConnectorTypeCVC", bundle: nil), forCellWithReuseIdentifier: "ConnectorTypeCVC")
        if let connectorTypeLayouts = connectorTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            connectorTypeLayouts.estimatedItemSize = .zero
        }
        
        vehicleColourCollectionView.register(UINib(nibName: "VehicleColorCVC", bundle: nil), forCellWithReuseIdentifier: "VehicleColorCVC")
        if let colourLayouts = vehicleColourCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            colourLayouts.estimatedItemSize = .zero
        }
        
        vehicleModelButton.setTitle("Select Vehicle Model", for: .normal)
        vehicleModelButton.isEnabled = true
        vehicleModelButton.isUserInteractionEnabled = true
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
        vehicleColourCollectionView.reloadData()
    }
}

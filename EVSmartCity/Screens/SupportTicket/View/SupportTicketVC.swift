//
//  SupportTicketVC.swift
//  EVSmartCity
//
//  Created by Hitman on 17/07/26.
//

import UIKit

class SupportTicketVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var supportTicketTitleLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var selectCategoryLabel: UILabel!
    @IBOutlet weak var selectCategoryCollectionView: UICollectionView!
    @IBOutlet weak var affectedStationLabel: UILabel!
    @IBOutlet weak var stationSearchbar: UISearchBar!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var describeTheProblemTF: UITextField!
    @IBOutlet weak var uploadEvidenceLabe: UILabel!
    @IBOutlet weak var uploadEvidenceStackView: UIStackView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var urgencyLevelLabel: UILabel!
    @IBOutlet var urgencyLevelButton: [UIButton]!
    @IBOutlet weak var reviewTicketButton: UIButton!
    @IBOutlet weak var uplodedEvidenceCollectionView: UICollectionView!
    
    let categories: [Category] = [
        Category(name: "Charging Issue", icon: "fuelpump"),
        Category(name: "Payment & Billing", icon: "creditcard"),
        Category(name: "App/Account", icon: "person.crop.circle"),
        Category(name: "Hardware Damage", icon: "wrench.and.screwdriver")
    ]
    
    var selectedCategoryIndex = 0
    var selectedUrgencyIndex: Int = -1
    
    private let imagePicker = UIImagePickerController()
    
    var uploadedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraButton.addDashedBorder()
        galleryButton.addDashedBorder()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func historyButtonAction(_ sender: Any) {
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func galleryButtonAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func urgencyLevelButtonAction(_ sender: UIButton) {
        guard let index = urgencyLevelButton.firstIndex(of: sender) else { return }
        selectedUrgencyIndex = index
        updateUrgencyButtons()
    }
    
    @IBAction func reviewTicketButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ReviewTicketVC") as! ReviewTicketVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

extension SupportTicketVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectCategoryCollectionView {
            return categories.count
        } else if collectionView == uplodedEvidenceCollectionView {
            return uploadedImages.count + 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == selectCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCategoryCVC", for: indexPath) as! SelectCategoryCVC
            let category = categories[indexPath.row]
            let isSelected = indexPath.row == selectedCategoryIndex
            cell.configure(with: category, isSelected: isSelected)
            return cell
        } else if collectionView == uplodedEvidenceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadEvidenceCVC",for: indexPath) as! UploadEvidenceCVC
            if indexPath.item < uploadedImages.count {
                cell.configure(image: uploadedImages[indexPath.item])
            } else {
                cell.configure(image: nil)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == selectCategoryCollectionView {
            let padding: CGFloat = 16 + 16 + 12
            let width = (collectionView.frame.width - padding) / 2
            return CGSize(width: width, height: 72)
        } else if collectionView == uplodedEvidenceCollectionView {
            return CGSize(width: 96, height: 96)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectCategoryCollectionView {
            selectedCategoryIndex = indexPath.row
            collectionView.reloadData()
        } else if collectionView == uplodedEvidenceCollectionView {
            if indexPath.item == uploadedImages.count {
                showImagePickerOptions()
            }
        }
        
    }
}

extension SupportTicketVC {
    func setUpUI() {
        imagePicker.delegate = self
        updateUrgencyButtons()
        setUpCollectionView()
        
        uplodedEvidenceCollectionView.isHidden = true
        cameraButton.isHidden = false
        galleryButton.isHidden = false
    }
    
    func setUpCollectionView() {
        selectCategoryCollectionView.register(UINib(nibName: "SelectCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "SelectCategoryCVC")
        if let layouts = selectCategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
            layouts.minimumLineSpacing = 12
            layouts.minimumInteritemSpacing = 12
            layouts.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        selectCategoryCollectionView.isScrollEnabled = false
        selectCategoryCollectionView.showsHorizontalScrollIndicator = false
        selectCategoryCollectionView.showsVerticalScrollIndicator = false
        
        uplodedEvidenceCollectionView.register(UINib(nibName: "UploadEvidenceCVC", bundle: nil), forCellWithReuseIdentifier: "UploadEvidenceCVC")
        if let layout = uplodedEvidenceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
        }
        uplodedEvidenceCollectionView.showsHorizontalScrollIndicator = false
        uplodedEvidenceCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func updateUrgencyButtons() {
        let greenColor = UIColor(hex: "#379D67")
        let darkColor = UIColor(hex: "#0F1724")

        for (index, button) in urgencyLevelButton.enumerated() {
            button.isSelected = (index == selectedUrgencyIndex)
            button.layer.cornerRadius = 16
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            if index == selectedUrgencyIndex {
                button.backgroundColor = greenColor
                button.setTitleColor(.white, for: .normal)
                button.setTitleColor(.white, for: .selected)
                button.layer.borderWidth = 0
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(darkColor, for: .normal)
                button.setTitleColor(darkColor, for: .selected)
                button.layer.borderWidth = 0
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            uploadedImages.append(image)
            cameraButton.isHidden = true
            galleryButton.isHidden = true
            uplodedEvidenceCollectionView.isHidden = false
            uplodedEvidenceCollectionView.reloadData()
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func showImagePickerOptions() {
        let alert = UIAlertController(title: "Upload Evidence",message: nil,preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

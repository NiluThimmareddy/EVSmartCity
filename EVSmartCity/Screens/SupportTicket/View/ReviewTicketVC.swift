//
//  ReviewTicketVC.swift
//  EVSmartCity
//
//  Created by Hitman on 20/07/26.
//

import UIKit

class ReviewTicketVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reviewTicketLabel: UILabel!
    @IBOutlet weak var categoryTitleLabelLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var urgencyTitleLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var stationLocationView: UIView!
    @IBOutlet weak var stationLocationTitleLabel: UILabel!
    @IBOutlet weak var landMarkLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var attachedEvidenceLabel: UILabel!
    @IBOutlet weak var attachedFilesLabel: UILabel!
    @IBOutlet weak var attachedFilesCollectionView: UICollectionView!
    @IBOutlet weak var notificationmethodLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var dataEncryptedSecureButton: UIButton!
    @IBOutlet weak var submitTicketButton: UIButton!
    
    let evidenceFiles : [AttachedEvidence] = [
        AttachedEvidence(image: "ic_evidenceFile1"),
        AttachedEvidence(image: "ic_evidenceFile2"),
        AttachedEvidence(image: "ic_evidenceFile3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
    }
    
    @IBAction func submitTicketButtonAction(_ sender: Any) {
    }
    
}

extension ReviewTicketVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return evidenceFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachedEvidenceCVC", for: indexPath) as! AttachedEvidenceCVC
        let images = evidenceFiles[indexPath.row]
        cell.configure(_with: images)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 96)
    }
}

extension ReviewTicketVC {
    func setUpUI() {
        attachedFilesLabel.layer.masksToBounds = true
        
        attachedFilesCollectionView.register(UINib(nibName: "AttachedEvidenceCVC", bundle: nil), forCellWithReuseIdentifier: "AttachedEvidenceCVC")
        if let layouts = attachedFilesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
            layouts.minimumLineSpacing = 12
            layouts.minimumInteritemSpacing = 12
        }
        attachedFilesCollectionView.showsHorizontalScrollIndicator = false
        attachedFilesCollectionView.showsVerticalScrollIndicator = false
    }
}

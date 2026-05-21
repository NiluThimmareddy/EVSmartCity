//
//  ReportAnIssueVC.swift
//  EVSmartCity
//
//  Created by Hitman on 20/05/26.


import UIKit

class ReportAnIssueVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reportAnIssueLabel: UILabel!
    @IBOutlet weak var whatTypeOfIssueThisLabel: UILabel!
    @IBOutlet weak var whatTypeOfIssueCollectionView: UICollectionView!
    @IBOutlet weak var discribeTheIssueLabel: UILabel!
    @IBOutlet weak var describeIssueTextView: UITextView!
    @IBOutlet weak var charactersCountsLabel: UILabel!
    @IBOutlet weak var addScreenshotsLabel: UILabel!
    @IBOutlet weak var uploadImagesButton: UIButton!
    @IBOutlet weak var youCanAdduptoFiveScreenshotsLabel: UILabel!
    @IBOutlet weak var contactEmailOrPhoneNumberLabel: UILabel!
    @IBOutlet weak var enterEmailOrPhoneNumberTF: UITextField!
    @IBOutlet weak var weMayContactYouLabel: UILabel!
    @IBOutlet weak var submitRepportButton: UIButton!
    
    let issueArray: [IssueModel] = [
        IssueModel(title: "Something not working",iconName: "exclamationmark.triangle"),
        IssueModel(title: "Payment / Billing Issue",iconName: "creditcard"),
        IssueModel(title: "Charging Station Issue",iconName: "bolt"),
        IssueModel(title: "Location / Map Issue",iconName: "mappin.and.ellipse"),
        IssueModel(title: "Account / Profile Issue",iconName: "person"),
        IssueModel(title: "Feedback / Suggestion",iconName: "bubble.left")
    ]
    var selectedIssueIndex: Int?
    let maxCharacterLimit = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadImagesButtonAction(_ sender: Any) {
    }
    
    @IBAction func submittReportButtonAction(_ sender: Any) {
        guard selectedIssueIndex != nil else {
            showAlert(title: "Validation Error", message: "Please select an issue type")
            return
        }
        
        // Validate description
        guard isValidDescription() else {
            showAlert(title: "Validation Error", message: "Please describe your issue in detail")
            return
        }
        submitReport()
    }
}

extension ReportAnIssueVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray && textView.text == "Please describe your issue in detail..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please describe your issue in detail..."
            textView.textColor = UIColor.lightGray
        }
        updateCharacterCount()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if textView.textColor == UIColor.lightGray && textView.text == "Please describe your issue in detail..." {
            if !text.isEmpty {
                textView.text = ""
                textView.textColor = UIColor.black
                return true
            }
            return false
        }
        return updatedText.count <= maxCharacterLimit
    }
}

extension ReportAnIssueVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhatTypeOfIssueCVC", for: indexPath) as! WhatTypeOfIssueCVC
        let data = issueArray[indexPath.row]
        cell.configure(with: data)
        cell.setSelected(indexPath.row == selectedIssueIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIssueIndex = indexPath.row
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 2
        let availableWidth = collectionView.frame.width - totalSpacing
        let itemWidth = availableWidth / 2
        let itemHeight: CGFloat = 54
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ReportAnIssueVC {
    
    func setUpUI() {
        whatTypeOfIssueCollectionView.register(UINib(nibName: "WhatTypeOfIssueCVC", bundle: nil), forCellWithReuseIdentifier: "WhatTypeOfIssueCVC")
        if let layout = whatTypeOfIssueCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        setupTextView()
    }
    
    func submitReport() {
        let selectedIssue = issueArray[selectedIssueIndex ?? 0]
        let description = describeIssueTextView.text ?? ""
        let contactInfo = enterEmailOrPhoneNumberTF.text ?? ""
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "ReportSubmittedSuccessfullyVC") as! ReportSubmittedSuccessfullyVC
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
    
    func isValidDescription() -> Bool {
        guard let text = describeIssueTextView.text else { return false }
        
        // Check if text is not empty and not placeholder
        let isNotPlaceholder = describeIssueTextView.textColor != UIColor.lightGray
        let isNotEmpty = !text.isEmpty
        let isNotDefaultText = text != "Please describe your issue in detail..."
        
        return isNotPlaceholder && isNotEmpty && isNotDefaultText
    }
    
    func setupTextView() {
        describeIssueTextView.delegate = self
        describeIssueTextView.text = "Please describe your issue in detail..."
        describeIssueTextView.textColor = UIColor.lightGray
        updateCharacterCount()
        describeIssueTextView.font = UIFont.systemFont(ofSize: 16)
    }
    
    func updateCharacterCount() {
        let currentCount = describeIssueTextView.text.count
        if describeIssueTextView.textColor == UIColor.lightGray && describeIssueTextView.text == "Please describe your issue in detail..." {
            charactersCountsLabel.text = "0/\(maxCharacterLimit)"
            charactersCountsLabel.textColor = UIColor.lightGray
        } else {
            charactersCountsLabel.text = "\(currentCount)/\(maxCharacterLimit)"
            if currentCount > maxCharacterLimit {
                charactersCountsLabel.textColor = UIColor.red
            } else if currentCount > maxCharacterLimit - 50 {
                charactersCountsLabel.textColor = UIColor.orange
            } else {
                charactersCountsLabel.textColor = UIColor.darkGray
            }
        }
    }
}



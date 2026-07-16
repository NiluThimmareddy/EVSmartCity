//
//  LanguagesVC.swift
//  EVSmartCity
//
//  Created by Hitman on 16/07/26.
//

import UIKit

protocol LanguagesVCDelegate: AnyObject {
    func didSelectLanguage(_ language: LanguageModel, selectedIndex: Int)
}

class LanguagesVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var selectYourPreferedLanguageLabel: UILabel!
    @IBOutlet weak var selectLanguagesTableView: UITableView!
    @IBOutlet weak var languagesTableViewHeightConstraint: NSLayoutConstraint!
    
    let languages: [LanguageModel] = [
        LanguageModel(nativeName: "English",englishName: "Default System Language"),
        LanguageModel(nativeName: "العربية",englishName: "Arabic"),
        LanguageModel(nativeName: "हिन्दी",englishName: "Hindi"),
        LanguageModel(nativeName: "ಕನ್ನಡ",englishName: "Kannada"),
        LanguageModel(nativeName: "தமிழ்",englishName: "Tamil"),
        LanguageModel(nativeName: "తెలుగు",englishName: "Telugu")
    ]
    
    weak var delegate: LanguagesVCDelegate?
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectLanguagesTableView.register(UINib(nibName: "SortOrderTVC", bundle: nil),forCellReuseIdentifier: "SortOrderTVC")
        selectLanguagesTableView.isScrollEnabled = false
        selectLanguagesTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectLanguagesTableView.layoutIfNeeded()
        languagesTableViewHeightConstraint.constant = selectLanguagesTableView.contentSize.height
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension LanguagesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOrderTVC") as! SortOrderTVC
        let language = languages[indexPath.row]
        cell.configure(with: language,isSelected: selectedIndex == indexPath.row,showPremium: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedLanguage = languages[indexPath.row]
        delegate?.didSelectLanguage(selectedLanguage,selectedIndex: indexPath.row)
        dismiss(animated: true)
    }
}

//
//  SortOrderVC.swift
//  EVSmartCity
//
//  Created by Hitman on 16/07/26.
//

import UIKit

protocol SortOrderVCDelegate: AnyObject {
    func didSelectSortOption(_ option: SortOption, selectedIndex: Int)
}

class SortOrderVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sortOrderlabel: UILabel!
    @IBOutlet weak var chooseHowYouLikeChargingLabel: UILabel!
    @IBOutlet weak var sortOrderTableView: UITableView!
    @IBOutlet weak var smartView: UIView!
    @IBOutlet weak var smartContextLabel: UILabel!
    @IBOutlet weak var switchToAIRecommendedLabel: UILabel!
    @IBOutlet weak var applySelectionButton: UIButton!
    
    let sortOptions: [SortOption] = [
        SortOption(title: "Distance",description: "Sort by proximity to your current location."),
        SortOption(title: "Price",description: "Sort by the lowest charging cost per kWh."),
        SortOption(title: "Reliability",description: "Sort by charger uptime and user ratings."),
        SortOption(title: "AI Recommended",description: "Smart sorting based on your vehicle and habits.")
    ]
    weak var delegate: SortOrderVCDelegate?
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortOrderTableView.register(UINib(nibName: "SortOrderTVC", bundle: nil), forCellReuseIdentifier: "SortOrderTVC")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func applySelectionbuttonAction(_ sender: Any) {
        let selectedOption = sortOptions[selectedIndex]
        delegate?.didSelectSortOption(selectedOption,selectedIndex: selectedIndex)
        dismiss(animated: true)
    }
}

extension SortOrderVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOrderTVC") as! SortOrderTVC
        let sort = sortOptions[indexPath.row]
        cell.configure(with: sort,isSelected: selectedIndex == indexPath.row,showPremium: indexPath.row == sortOptions.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

//
//  AddYourVehicleVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.

import UIKit

class AddYourVehicleVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addYourVehicleTitleLabel: UILabel!
    @IBOutlet weak var setp1of4Label: UILabel!
    @IBOutlet weak var whatisYourVehicleBrandLabel: UILabel!
    @IBOutlet weak var selectYourCarsLabel: UILabel!
    @IBOutlet weak var vehicleSearchBar: UISearchBar!
    @IBOutlet weak var vehiclesListTableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var vehicleDetails = [
        VehicleBrandModel(brandImage: "ic_Tesla", brandname: "Tesla", brandDescription: ""),
        VehicleBrandModel(brandImage: "ic_BMW", brandname: "BMW",brandDescription: ""),
        VehicleBrandModel(brandImage: "ic_Hyundai", brandname: "Hyundai",brandDescription: ""),
        VehicleBrandModel(brandImage: "ic_KIA", brandname: "KIA",brandDescription: ""),
        VehicleBrandModel(brandImage: "ic_Tata", brandname: "Tata Motors",brandDescription: "")
    ]
    
    var filteredVehicles: [VehicleBrandModel] = []
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        vehiclesListTableView.register(UINib(nibName: "AddVehicleTVC", bundle: nil), forCellReuseIdentifier: "AddVehicleTVC")
        vehicleSearchBar.delegate = self
        vehicleSearchBar.applyShadow()
        filteredVehicles = vehicleDetails
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        if let index = selectedIndex {
            let storyboard = storyboard?.instantiateViewController(withIdentifier: "SelectYourModelVC") as! SelectYourModelVC
            storyboard.modalPresentationStyle = .fullScreen
            present(storyboard, animated: true, completion: nil)
        } else {
            print("Please select a vehicle")
        }
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        openHomePage()
    }
    
}

extension AddYourVehicleVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddVehicleTVC") as! AddVehicleTVC
        let details = filteredVehicles[indexPath.row]
        cell.brandImgView.image = UIImage(named: details.brandImage)
        cell.vehicleBrandNameLabel.text = details.brandname
        let isSelected = vehicleDetails.firstIndex(where: {
            $0.brandname == details.brandname
        }) == selectedIndex
        cell.configure(isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = filteredVehicles[indexPath.row]
        let actualIndex = vehicleDetails.firstIndex(where: {
            $0.brandname == selectedItem.brandname
        })
        
        if selectedIndex == actualIndex {
            selectedIndex = nil
        } else {
            selectedIndex = actualIndex
        }
        tableView.reloadData()
    }
}

extension AddYourVehicleVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredVehicles = vehicleDetails
        } else {
            filteredVehicles = vehicleDetails.filter {
                $0.brandname.lowercased().contains(searchText.lowercased())
            }
        }
        vehiclesListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

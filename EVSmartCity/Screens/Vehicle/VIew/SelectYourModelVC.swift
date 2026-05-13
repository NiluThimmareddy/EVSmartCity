//
//  SelectYourModelVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit

class SelectYourModelVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectYourModelTitleLabel: UILabel!
    @IBOutlet weak var step2of4Label: UILabel!
    @IBOutlet weak var selectYourTeslaModelLabel: UILabel!
    @IBOutlet weak var chooseYourModelLabel: UILabel!
    @IBOutlet weak var modelSearchBar: UISearchBar!
    @IBOutlet weak var modelListTabelView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    var vehicleModel = [
        VehicleModel(modelImage: "ic_redCar", modelName: "ModelS", connectorType: "CCS2 • AC ⚡ + DC ⚡⚡"),
        VehicleModel(modelImage: "ic_whiteCar", modelName: "Model1", connectorType: "CCS2 • AC ⚡ + DC ⚡⚡"),
        VehicleModel(modelImage: "ic_blue", modelName: "Model2", connectorType: "CCS2 • AC ⚡ + DC ⚡⚡"),
        VehicleModel(modelImage: "ic_redCar", modelName: "Model3", connectorType: "CCS2 • AC ⚡ + DC ⚡⚡"),
        VehicleModel(modelImage: "ic_whiteCar", modelName: "Model4", connectorType: "CCS2 • AC ⚡ + DC ⚡⚡")
    ]
    
    var filteredVehicles: [VehicleModel] = []
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        modelListTabelView.register(UINib(nibName: "SelectYourModelTVC", bundle: nil), forCellReuseIdentifier: "SelectYourModelTVC")
        modelSearchBar.delegate = self
        modelSearchBar.applyShadow()
        filteredVehicles = vehicleModel
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        if let index = selectedIndex {
            let storyboard = storyboard?.instantiateViewController(withIdentifier: "EnterVehicleDetails") as! EnterVehicleDetails
            storyboard.modalPresentationStyle = .fullScreen
            present(storyboard, animated: true, completion: nil)
        } else {
            print("Please select a vehicle")
        }
    }
}

extension SelectYourModelVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectYourModelTVC") as! SelectYourModelTVC
        let details = filteredVehicles[indexPath.row]
        cell.carModelImgView.image = UIImage(named: details.modelImage)
        cell.modelNameLabel.text = details.modelName
        let isSelected = vehicleModel.firstIndex(where: {
            $0.modelName == details.modelName
        }) == selectedIndex
        cell.configure(isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = filteredVehicles[indexPath.row]
        let actualIndex = vehicleModel.firstIndex(where: {
            $0.modelName == selectedItem.modelName
        })
        
        if selectedIndex == actualIndex {
            selectedIndex = nil
        } else {
            selectedIndex = actualIndex
        }
        tableView.reloadData()
    }
}

extension SelectYourModelVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredVehicles = vehicleModel
        } else {
            filteredVehicles = vehicleModel.filter {
                $0.modelName.lowercased().contains(searchText.lowercased())
            }
        }
        modelListTabelView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

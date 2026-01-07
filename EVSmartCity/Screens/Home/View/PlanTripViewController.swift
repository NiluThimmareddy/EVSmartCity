//
//  PlanTripViewController.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import UIKit
import MapKit
import CoreLocation

class PlanTripViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    
    private let viewModel = PlanTripViewModel()
    private let locationViewModel = LocationSearchViewModel()
    var activeTextField: UITextField?
    private var isSelectingSource = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.fetchCurrentLocation()
        setupBindings()
    }
    

    func setupBindings(){
        viewModel.onCurrentLocationUpdate = { [weak self] location in
            DispatchQueue.main.async {
                self?.sourceTextField.text = location.description
            }
        }
        
        viewModel.onSuggestionsUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.locationTableView.isHidden = false
                self?.locationTableView.reloadData()
            }
        }
    }
   
    func setupUI(){
        sourceTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        destinationTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        sourceTextField.delegate = self
        destinationTextField.delegate = self
        
        locationTableView.isHidden = true
    }
    
    @objc func textChanged(_ textField : UITextField) {
        activeTextField = textField
        viewModel.searchLocation(text: textField.text ?? "")
    }

    func userSelectedLocation(_ completion: MKLocalSearchCompletion, isSource: Bool) {
        
        locationViewModel.fetchCoordinates(from: completion) { coordinate in
            guard let coordinate else { return }
            
            let recent = RecentLocation(title: completion.title, latitude: coordinate.latitude, longitude: coordinate.longitude, isSource: isSource, date: Date()
            )
            
            RecentSearchManager.shared.save(recent)
            
            print("Saved location:", coordinate)
        }
    }
}

extension PlanTripViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let item = viewModel.suggestion(at: indexPath.row)
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.suggestion(at: indexPath.row)
        activeTextField?.text = "\(selected.title), \(selected.subtitle)"
        
        tableView.isHidden = true
        view.endEditing(true)
        
//        let isSource = (activeTextField == sourceTextField)
        
//        userSelectedLocation(selected, isSource: isSource)
    }
}

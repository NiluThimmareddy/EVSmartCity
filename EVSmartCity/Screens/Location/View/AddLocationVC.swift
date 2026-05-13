//
//  AddLocationVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit
import CoreLocation
import MapKit

class AddLocationVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addLocationTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var useDeviceLocationButton: UIButton!
    @IBOutlet weak var locationTabelView: UITableView!
    @IBOutlet weak var addLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    let searchCompleter = MKLocalSearchCompleter()
    var searchSuggestions: [MKLocalSearchCompletion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        searchBar.delegate = self
        searchBar.applyShadow()
        
        locationTabelView.delegate = self
        locationTabelView.dataSource = self
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func useDeviceLocationButtonAction(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func addLocationButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Vehicle", bundle: nil).instantiateViewController(withIdentifier: "AddYourVehicleVC") as! AddYourVehicleVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}

extension AddLocationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let result = searchSuggestions[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.subtitle
        cell.imageView?.image = UIImage(systemName: "location") // "dot.scope"
        cell.imageView?.tintColor = UIColor(hex: "#379D67")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        
        let completion = searchSuggestions[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            if let item = response?.mapItems.first {
                let lat = item.placemark.coordinate.latitude
                let lng = item.placemark.coordinate.longitude
                print("Selected:", item.name ?? "")
                print("Lat:", lat, "Lng:", lng)
                self.searchBar.text = completion.title
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddLocationVC: CLLocationManagerDelegate, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchSuggestions = completer.results
        locationTabelView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search Error:", error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print("Latitude:", latitude)
        print("Longitude:", longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let place = placemarks?.first {
                let title = place.name ?? "Current Location"
                let subtitle = "\(place.locality ?? ""), \(place.country ?? "")"
                self.searchBar.text = title
                print("Address:", title, subtitle)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error:", error.localizedDescription)
    }
}

//
//  SetLocationVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit
import CoreLocation

class SetLocationVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var setLocationTitleLabel: UILabel!
    @IBOutlet weak var allowLocationTitlelabel: UILabel!
    @IBOutlet weak var accessToShowNearbyEVLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var deviceLocationButton: UIButton!
    @IBOutlet weak var enterManuallyButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deviceLocationButtonAction(_ sender: Any) {
        checkLocationPermission()
        let storyboard = UIStoryboard(name: "Vehicle", bundle: nil).instantiateViewController(withIdentifier: "AddYourVehicleVC") as! AddYourVehicleVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func entermanuallyButtonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddLocationVC") as! AddLocationVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension SetLocationVC : CLLocationManagerDelegate {
    func checkLocationPermission() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            
        case .denied, .restricted:
            showSettingsAlert()
            
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            showSettingsAlert()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        print("Latitude:", latitude)
        print("Longitude:", longitude)
        print("Location fetched successfully")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error:", error.localizedDescription)
        showAlert("Unable to fetch location. Please try again.")
    }
}

extension SetLocationVC {
    func setUpUI() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSettingsAlert() {
        let alert = UIAlertController(
            title: "Location Permission Needed",
            message: "Please enable location access in Settings to use your current location.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

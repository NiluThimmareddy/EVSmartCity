////
////  PlanTripViewController.swift
////  EVSmartCity
////
////  Created by Toqsoft on 05/01/26.


import UIKit
import MapKit
import CoreLocation

class PlanTripViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    private let viewModel = PlanTripViewModel()
    private let locationViewModel = LocationSearchViewModel()
    private var sourceCoordinate: CLLocationCoordinate2D?
    private var destinationCoordinate: CLLocationCoordinate2D?
    private var isSelectingSource = true
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchCurrentLocation()
        setupBindings()
        mapView.delegate = self
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
        self.mapView.isHidden = true
        locationTableView.isHidden = true
    }
    
    @objc func textChanged(_ textField : UITextField) {
        activeTextField = textField
        viewModel.searchLocation(text: textField.text ?? "")
    }

    func userSelectedLocation(_ completion: MKLocalSearchCompletion, isSource: Bool) {
        
        locationViewModel.fetchCoordinates(from: completion) { coordinate in
            guard let coordinate else { return }
            
            if isSource {
                self.sourceCoordinate = coordinate
            }else{
                self.destinationCoordinate = coordinate
            }
            
            let recent = RecentLocation(title: completion.title, latitude: coordinate.latitude, longitude: coordinate.longitude, isSource: isSource, date: Date()
            )
            
            RecentSearchManager.shared.save(recent)
            
            DispatchQueue.main.async {
                self.mapView.isHidden = false
                self.addPin(at: coordinate, isSource: isSource)
                self.drawRouteIfPossible()
            }
            print("Saved location:", coordinate)
        }
    }
}
//
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
        
        let mapItem = viewModel.mapCompletion(at: indexPath.row)
        activeTextField?.text = "\(selected.title), \(selected.subtitle)"
        
        tableView.isHidden = true
//        mapView.isHidden = true
        view.endEditing(true)
        
        let isSource = (activeTextField == sourceTextField)
        
        userSelectedLocation(mapItem, isSource: isSource)
    }
}
//
extension PlanTripViewController : MKMapViewDelegate {
    func addPin(at coordinate: CLLocationCoordinate2D, isSource: Bool) {
        
        mapView.annotations.forEach {
            if $0.title == (isSource ? "source" : "destination"){
                mapView.removeAnnotation($0)
            }
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = isSource ? "source" : "destination"
        
        mapView.addAnnotation(annotation)
    }
    
    func drawRouteIfPossible(){
        guard let source = sourceCoordinate, let destination = destinationCoordinate else { return }
        
        mapView.removeOverlays(mapView.overlays)
        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate() { [weak self] response, error in
            
            guard let self, let route = response?.routes.first else { return }
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 80, left: 40, bottom: 80, right: 40) , animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}

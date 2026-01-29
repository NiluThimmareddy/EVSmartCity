//
//  EVMapViewController.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//


import UIKit
import MapKit
import Combine
import CoreLocation

class EVMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stationDetailsView: UIView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var plugScoreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var plugTypesTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var stationDetailsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel: any EVStationListViewModelProtocol
    private var mapManager: MapManager
    private var locationManager = CLLocationManager()
    private var currentUserLocation: CLLocation?
    private var routeOverlay: MKOverlay?
    private var routeAnnotations: [MKAnnotation] = []
    private var cancellables = Set<AnyCancellable>()
    private var isShowingDirections = false
    private var isUserLocationInitialized = false
    private var shouldCenterOnUserLocation = false
    private var searchResults: [EVStationAnnotationViewModel] = []
    private var isSearching = false
    
    init?(coder: NSCoder, viewModel: any EVStationListViewModelProtocol) {
        self.viewModel = viewModel
        self.mapManager = MapManager()
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = EVStationListViewModel()
        self.mapManager = MapManager()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupTableView()
        setupMapView()
        setupZoomButtons()
        setupLocationManager()
        setupSearchBar()
        viewModel.loadStations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateZoomButtonStates()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        zoomMap(zoomIn: true)
        
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        zoomMap(zoomIn: false)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        viewModel.deselectStation()
        clearRoute()
        clearSearchIfNeeded()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        showFilterOptions()
    }

    @IBAction func getDirectionsButtonAction(_ sender: Any) {
        if isShowingDirections {
            clearRoute()
            return
        }
        
        guard let observableVM = viewModel as? EVStationListViewModel,
              let selectedStation = observableVM.selectedStation,
              let stationLocation = observableVM.annotations.first(where: { $0.stationId == selectedStation.stationId })?.coordinate else {
            showAlert(title: "Error", message: "No station selected")
            return
        }
        
        guard let userLocation = currentUserLocation else {
            requestLocation()
            showAlert(title: "Location Required", message: "Please wait for location to load or enable location services")
            return
        }
        hideStationDetails()
        
        showMapOptions(
                from: userLocation.coordinate,
                to: stationLocation
            )
        
//        showRoute(from: userLocation.coordinate, to: stationLocation)
    }
    
    @IBAction func currentLocationButtonTapped(_ sender: UIButton) {
        centerMapOnUserLocation()
    }
    
    private func setupUI() {
        stationDetailsView.layer.cornerRadius = 12
        stationDetailsView.layer.shadowColor = UIColor.black.cgColor
        stationDetailsView.layer.shadowOpacity = 0.2
        stationDetailsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stationDetailsView.layer.shadowRadius = 4
        stationDetailsView.isHidden = true
        dismissButton.layer.cornerRadius = 8
        errorLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStationDetailsTap(_:)))
        stationDetailsView.addGestureRecognizer(tapGesture)
        stationDetailsView.isUserInteractionEnabled = true
        currentLocationButton.backgroundColor = .white
        currentLocationButton.tintColor = .systemBlue
        currentLocationButton.layer.cornerRadius = 8
        currentLocationButton.layer.borderColor = UIColor.systemBlue.cgColor
        currentLocationButton.layer.borderWidth = 1
        
        // Add keyboard dismissal tap gesture
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        viewTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(viewTapGesture)
    }
    
    private func setupBindings() {
        if let observableVM = viewModel as? EVStationListViewModel {
            observableVM.$annotations
                .receive(on: DispatchQueue.main)
                .sink { [weak self] annotations in
                    self?.updateMapAnnotations(annotations)
                }
                .store(in: &cancellables)
            
            observableVM.$selectedStation
                .receive(on: DispatchQueue.main)
                .sink { [weak self] (stationDetailsVM: StationDetailsViewModel?) in
                    if let vm = stationDetailsVM {
                        self?.showStationDetails(vm)
                    } else {
                        self?.hideStationDetails()
                        self?.clearRoute()
                    }
                }
                .store(in: &cancellables)
            
            observableVM.$isLoading
                .receive(on: DispatchQueue.main)
                .sink { [weak self] (isLoading: Bool) in
                    self?.loadingIndicator.isHidden = !isLoading
                    isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
                }
                .store(in: &cancellables)
            
            observableVM.$errorMessage
                .receive(on: DispatchQueue.main)
                .sink { [weak self] (errorMessage: String?) in
                    guard let self = self else { return }
                    if let errorMessage = errorMessage, !errorMessage.isEmpty {
                        self.errorLabel.text = errorMessage
                        self.errorLabel.isHidden = false
                    } else {
                        self.errorLabel.isHidden = true
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    private func setupTableView() {
        plugTypesTableView.register(UINib(nibName: "PlugTypesTVC", bundle: nil), forCellReuseIdentifier: "PlugTypesTVC")
        plugTypesTableView.rowHeight = UITableView.automaticDimension
        plugTypesTableView.estimatedRowHeight = 40
        plugTypesTableView.isScrollEnabled = false
        plugTypesTableView.dataSource = self
        plugTypesTableView.delegate = self
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        mapView.setRegion(mapManager.currentRegion, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
    }
    
    private func setupZoomButtons() {
        plusButton.layer.cornerRadius = 8
        plusButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        plusButton.layer.borderColor = UIColor.systemBlue.cgColor
        plusButton.layer.borderWidth = 1
        plusButton.layer.masksToBounds = true

        minusButton.layer.borderColor = UIColor.systemBlue.cgColor
        minusButton.layer.borderWidth = 1
        minusButton.layer.masksToBounds = true
        
        currentLocationButton.layer.cornerRadius = 8
        currentLocationButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        currentLocationButton.layer.borderColor = UIColor.systemBlue.cgColor
        currentLocationButton.layer.borderWidth = 1
        currentLocationButton.layer.masksToBounds = true

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTapGesture)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        checkLocationAuthorization()
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search stations..."
        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.showsCancelButton = true
        
        // Change to default or prominent style instead of minimal
        searchBar.searchBarStyle = .default // or .prominent
        
        // Set background color to make it more visible
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .white
        
        // Set text field background color
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.textColor = .black
        } else {
            // For older iOS versions
            if let textField = searchBar.value(forKey: "searchField") as? UITextField {
                textField.backgroundColor = .white
                textField.textColor = .black
            }
        }
        
        // Add border and corner radius for better visibility
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.systemGray4.cgColor
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        
        // Set tint color
        searchBar.tintColor = .systemBlue
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        case .denied, .restricted:
            shouldCenterOnUserLocation = false
            print("Location access denied or restricted")
        @unknown default:
            break
        }
    }
    
    private func requestLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func centerMapOnUserLocation() {
        print("Center map button tapped")
        switch locationManager.authorizationStatus {
        case .denied, .restricted:
            showLocationPermissionAlert()
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            shouldCenterOnUserLocation = true
            return
        default:
            break
        }
        
        if let userLocation = currentUserLocation {
            print("Using currentUserLocation: \(userLocation.coordinate)")
            centerMapOnUserLocation(at: userLocation.coordinate)
            return
        }
        
        if let mapUserLocation = mapView.userLocation.location {
            print("Using mapView userLocation: \(mapUserLocation.coordinate)")
            currentUserLocation = mapUserLocation
            centerMapOnUserLocation(at: mapUserLocation.coordinate)
            return
        }
        
        print("No location available, starting updates...")
        shouldCenterOnUserLocation = true
        locationManager.startUpdatingLocation()
        showTemporaryMessage("Getting your location...")
    }
    
    private func centerMapOnUserLocation(at coordinate: CLLocationCoordinate2D) {
        print("Centering map at: \(coordinate)")
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        
        mapView.setRegion(region, animated: true)
        showUserLocationAnnotation(at: coordinate)
        updateCurrentLocationButton(isActive: true)
    }
    
    private func showTemporaryMessage(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.layer.cornerRadius = 8
        messageLabel.clipsToBounds = true
        messageLabel.alpha = 0
        view.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
            messageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        UIView.animate(withDuration: 0.3) {
            messageLabel.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.3, animations: {
                messageLabel.alpha = 0
            }) { _ in
                messageLabel.removeFromSuperview()
            }
        }
    }
    
    private func showUserLocationAnnotation(at coordinate: CLLocationCoordinate2D) {
        let userAnnotations = mapView.annotations.filter {
            $0.title == "You are here" || $0 is MKUserLocation
        }
        mapView.removeAnnotations(userAnnotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "You are here"
        annotation.subtitle = "Current location"
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let index = self.mapView.annotations.firstIndex(where: { $0.title == "You are here" }) {
                let annotationToRemove = self.mapView.annotations[index]
                self.mapView.deselectAnnotation(annotationToRemove, animated: true)
                self.mapView.removeAnnotation(annotationToRemove)
            }
        }
    }
    
    private func updateCurrentLocationButton(isActive: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.currentLocationButton.backgroundColor = isActive ? .systemBlue : .white
            self.currentLocationButton.tintColor = isActive ? .white : .systemBlue
            self.currentLocationButton.setImage(UIImage(systemName: isActive ? "dot.scope" : "dot.scope"), for: .normal)
            
            if isActive {
                let pulse = CABasicAnimation(keyPath: "transform.scale")
                pulse.duration = 0.3
                pulse.fromValue = 1.0
                pulse.toValue = 1.2
                pulse.autoreverses = true
                pulse.repeatCount = 1
                self.currentLocationButton.layer.add(pulse, forKey: "pulse")
            }
        }
        
        if isActive {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.updateCurrentLocationButton(isActive: false)
            }
        }
    }
    
    private func showRoute(from startCoordinate: CLLocationCoordinate2D, to endCoordinate: CLLocationCoordinate2D) {
        guard let observableVM = viewModel as? EVStationListViewModel else { return }
        
        clearRoute()
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoordinate))
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                
                if let error = error {
                    self.showAlert(title: "Routing Error", message: error.localizedDescription)
                    return
                }
                
                guard let route = response?.routes.first else {
                    self.showAlert(title: "Error", message: "No route found")
                    return
                }
                
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                self.routeOverlay = route.polyline
                
                let startAnnotation = MKPointAnnotation()
                startAnnotation.coordinate = startCoordinate
                startAnnotation.title = "Your Location"
                self.mapView.addAnnotation(startAnnotation)
                self.routeAnnotations.append(startAnnotation)
                
                let endAnnotation = MKPointAnnotation()
                endAnnotation.coordinate = endCoordinate
                endAnnotation.title = "Destination"
                self.mapView.addAnnotation(endAnnotation)
                self.routeAnnotations.append(endAnnotation)
                
                let stationsAlongRoute = self.findStationsAlongRoute(route: route, stations: observableVM.annotations)
                
                for station in stationsAlongRoute {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = station.coordinate
                    annotation.title = station.title
                    annotation.subtitle = "Charging Station"
                    self.mapView.addAnnotation(annotation)
                    self.routeAnnotations.append(annotation)
                }
                
                self.zoomToShowRoute(route: route)
                self.showStationsAlongRoute(stations: stationsAlongRoute)
                self.isShowingDirections = true
            }
        }
    }
    
    private func findStationsAlongRoute(route: MKRoute, stations: [EVStationAnnotationViewModel], maxDistance: CLLocationDistance = 5000) -> [EVStationAnnotationViewModel] {
        var stationsAlongRoute: [EVStationAnnotationViewModel] = []
        
        for station in stations {
            let stationLocation = CLLocation(latitude: station.coordinate.latitude,
                                           longitude: station.coordinate.longitude)
            for coordinate in route.polyline.coordinates {
                let routePoint = CLLocation(latitude: coordinate.latitude,
                                          longitude: coordinate.longitude)
                let distance = stationLocation.distance(from: routePoint)
                
                if distance <= maxDistance {
                    stationsAlongRoute.append(station)
                    break
                }
            }
        }
        
        return stationsAlongRoute
    }
    
    private func showStationsAlongRoute(stations: [EVStationAnnotationViewModel]) {
        if stations.isEmpty {
            showAlert(title: "Stations Along Route", message: "No charging stations found along your route.")
            return
        }
        
        let stationCount = stations.count
        let message = "Found \(stationCount) charging station\(stationCount == 1 ? "" : "s") along your route"
        
        let alert = UIAlertController(title: "Stations Along Route",
                                    message: message,
                                    preferredStyle: .actionSheet)
        
        for (index, station) in stations.enumerated() {
            let distance = calculateDistanceToRoute(for: station)
            let action = UIAlertAction(title: "\(index + 1). \(station.title) (\(distance))",
                                     style: .default) { [weak self] _ in
                if let observableVM = self?.viewModel as? EVStationListViewModel {
                    observableVM.selectStation(withId: station.stationId)
                }
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = getDirectionsButton
            popoverController.sourceRect = getDirectionsButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    private func calculateDistanceToRoute(for station: EVStationAnnotationViewModel) -> String {
        guard let userLocation = currentUserLocation else { return "N/A" }
        
        let stationLocation = CLLocation(latitude: station.coordinate.latitude,
                                       longitude: station.coordinate.longitude)
        let distance = userLocation.distance(from: stationLocation)
        
        if distance < 1000 {
            return String(format: "%.0f m", distance)
        } else {
            return String(format: "%.1f km", distance / 1000)
        }
    }
    
    private func zoomToShowRoute(route: MKRoute) {
        let rect = route.polyline.boundingMapRect
        let padding: CGFloat = 50
        
        let mapRect = mapView.mapRectThatFits(rect, edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        let region = MKCoordinateRegion(mapRect)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func clearRoute() {
        if let overlay = routeOverlay {
            mapView.removeOverlay(overlay)
            routeOverlay = nil
        }
        mapView.removeAnnotations(routeAnnotations)
        routeAnnotations.removeAll()
        isShowingDirections = false
    }
    
    private func updateMapAnnotations(_ annotationVMs: [EVStationAnnotationViewModel]) {
        let annotationsToRemove = mapView.annotations.filter { annotation in
            !(annotation is MKUserLocation) &&
            !routeAnnotations.contains(where: { $0 === annotation }) &&
            annotation.title != "You are here"
        }
        mapView.removeAnnotations(annotationsToRemove)
        
        let annotations = annotationVMs.map { vm -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = vm.coordinate
            annotation.title = vm.title
            annotation.subtitle = vm.subtitle
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        
        if !annotations.isEmpty && !isShowingDirections && !isUserLocationInitialized {
            zoomToFitAllStations(annotationVMs)
        }
    }
    
    private func showStationDetails(_ viewModel: StationDetailsViewModel) {
        updateStationDetailsUI(with: viewModel)
        priceLabel.isHidden = false
        priceLabel.alpha = 0
        
        stationDetailsView.alpha = 0
        stationDetailsView.isHidden = false
        updateStationDetailsHeight(connectorsCount: viewModel.connectors.count)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.stationDetailsView.alpha = 1
            self.priceLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateStationDetailsUI(with viewModel: StationDetailsViewModel) {
        stationNameLabel.text = viewModel.stationName
        
        if let userLocation = currentUserLocation,
           let observableVM = self.viewModel as? EVStationListViewModel,
           let stationAnnotation = observableVM.annotations.first(where: { $0.stationId == viewModel.stationId }) {
            
            let stationLocation = CLLocation(latitude: stationAnnotation.coordinate.latitude,
                                           longitude: stationAnnotation.coordinate.longitude)
            let distance = userLocation.distance(from: stationLocation)
            if distance < 1000 {
                distanceLabel.text = String(format: "%.0f m away", distance)
            } else {
                distanceLabel.text = String(format: "%.1f km away", distance / 1000)
            }
        } else {
            distanceLabel.text = viewModel.distanceText
        }
        
        priceLabel.isHidden = false
        priceLabel.text = viewModel.pricingText
        priceLabel.textColor = .systemBlue
        
        if let scoreText = viewModel.plugScoreText {
            plugScoreLabel.isHidden = false
            plugScoreLabel.text = scoreText
            plugScoreLabel.textColor = viewModel.plugScoreColor
            plugScoreLabel.backgroundColor = viewModel.plugScoreColor.withAlphaComponent(0.1)
        } else {
            plugScoreLabel.isHidden = true
        }
        
        plugTypesTableView.reloadData()
    }
    
    private func hideStationDetails() {
        UIView.animate(withDuration: 0.3, animations: {
            self.stationDetailsView.alpha = 0
            self.priceLabel.alpha = 0
            self.tableViewheightConstraint.constant = 0
            self.stationDetailsViewHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.stationDetailsView.isHidden = true
            self.priceLabel.isHidden = true
        }
    }
    
    private func updateStationDetailsHeight(connectorsCount: Int) {
        let rowHeight: CGFloat = 40
        let tableHeight = CGFloat(connectorsCount) * rowHeight
        let maxTableHeight: CGFloat = 200
        let clampedTableHeight = min(maxTableHeight, tableHeight)
        let baseHeight: CGFloat = 100
        let totalHeight = baseHeight + clampedTableHeight
        
        UIView.animate(withDuration: 0.3) {
            self.tableViewheightConstraint.constant = clampedTableHeight
            self.stationDetailsViewHeightConstraint.constant = totalHeight
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateZoomButtonStates() {
        let currentSpan = mapView.region.span.latitudeDelta
        
        plusButton.isEnabled = currentSpan > mapManager.minZoomLevel
        plusButton.alpha = plusButton.isEnabled ? 1.0 : 0.5
        
        minusButton.isEnabled = currentSpan < mapManager.maxZoomLevel
        minusButton.alpha = minusButton.isEnabled ? 1.0 : 0.5
    }
    
    private func zoomMap(zoomIn: Bool) {
        let newRegion = mapManager.calculateZoomedRegion(
            zoomIn: zoomIn,
            from: mapView.region
        )
        
        UIView.animate(withDuration: 0.3) {
            self.mapView.setRegion(newRegion, animated: true)
        }
        
        updateZoomButtonStates()
        provideHapticFeedback()
    }
    
    private func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func zoomToFitAllStations(_ annotationVMs: [EVStationAnnotationViewModel]) {
        mapManager.zoomToFitAnnotations(annotationVMs)
        mapView.setRegion(mapManager.currentRegion, animated: true)
    }
    
    private func showLocationPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Access Required",
            message: "Please enable location services in Settings to use the location features.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func searchStations(with query: String) {
        guard let observableVM = viewModel as? EVStationListViewModel else { return }
        
        if query.isEmpty {
            clearSearch()
            return
        }
        
        isSearching = true
        searchResults = observableVM.searchStations(with: query)
        updateMapWithSearchResults()
        handleSearchResults(for: query)
    }

    private func updateMapWithSearchResults() {
        // Remove all non-essential annotations
        let annotationsToRemove = mapView.annotations.filter { annotation in
            !(annotation is MKUserLocation) &&
            !routeAnnotations.contains(where: { $0 === annotation }) &&
            annotation.title != "You are here" &&
            !searchResults.contains(where: {
                $0.coordinate.latitude == annotation.coordinate.latitude &&
                $0.coordinate.longitude == annotation.coordinate.longitude
            })
        }
        mapView.removeAnnotations(annotationsToRemove)
        
        // Add search result annotations
        for station in searchResults {
            let existingAnnotation = mapView.annotations.first { annotation in
                annotation.coordinate.latitude == station.coordinate.latitude &&
                annotation.coordinate.longitude == station.coordinate.longitude
            }
            
            if existingAnnotation == nil {
                let annotation = MKPointAnnotation()
                annotation.coordinate = station.coordinate
                annotation.title = station.title
                annotation.subtitle = station.subtitle
                mapView.addAnnotation(annotation)
            }
        }
        
        // Zoom to search results
        if !searchResults.isEmpty {
            zoomToSearchResults()
        }
    }

    private func handleSearchResults(for query: String) {
        // If only one result found, select and zoom to it
        if searchResults.count == 1 {
            let station = searchResults[0]
            if let observableVM = viewModel as? EVStationListViewModel {
                observableVM.selectStation(withId: station.stationId)
                zoomToStation(station)
            }
        } else if searchResults.isEmpty {
            // No results found
            showNoResultsMessage(for: query)
        }
    }

    private func zoomToStation(_ station: EVStationAnnotationViewModel) {
        let region = MKCoordinateRegion(
            center: station.coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        mapView.setRegion(region, animated: true)
    }

    private func zoomToSearchResults() {
        guard !searchResults.isEmpty else { return }
        
        var minLat = searchResults[0].coordinate.latitude
        var maxLat = searchResults[0].coordinate.latitude
        var minLon = searchResults[0].coordinate.longitude
        var maxLon = searchResults[0].coordinate.longitude
        
        for station in searchResults {
            let lat = station.coordinate.latitude
            let lon = station.coordinate.longitude
            
            minLat = min(minLat, lat)
            maxLat = max(maxLat, lat)
            minLon = min(minLon, lon)
            maxLon = max(maxLon, lon)
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.2, // Add 20% padding
            longitudeDelta: (maxLon - minLon) * 1.2
        )
        
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }

    private func showNoResultsMessage(for query: String) {
        let alert = UIAlertController(
            title: "No Results",
            message: "No stations found for '\(query)'",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }

    private func clearSearch() {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        isSearching = false
        searchResults.removeAll()
        
        if let observableVM = viewModel as? EVStationListViewModel {
            // Reload all annotations
            updateMapAnnotations(observableVM.annotations)
        }
        
        view.endEditing(true)
    }

    private func clearSearchIfNeeded() {
        if isSearching {
            clearSearch()
        }
    }
    
    @objc private func handleDoubleTapGesture(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        mapManager.zoom(to: coordinate)
        mapView.setRegion(mapManager.currentRegion, animated: true)
    }
    
    @objc private func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: mapView)
        
        let tappedAnnotations = mapView.annotations.filter { annotation in
            if let annotationView = mapView.view(for: annotation) {
                return annotationView.frame.contains(location)
            }
            return false
        }
        
        if tappedAnnotations.isEmpty {
            viewModel.deselectStation()
            clearRoute()
            clearSearchIfNeeded()
        }
    }
    
    @objc private func handleStationDetailsTap(_ gesture: UITapGestureRecognizer) {
        if let observableVM = viewModel as? EVStationListViewModel,
           let selectedStation = observableVM.selectedStation,
           stationDetailsView.isHidden == false {
            navigateToStationDetails(with: selectedStation)
        }
    }
    
    private func navigateToStationDetails(with viewModel: StationDetailsViewModel) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "ChargingStationDetailsVC") as? ChargingStationDetailsVC {
            detailsVC.stationId = viewModel.stationId
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    private func showFilterOptions() {
        let alert = UIAlertController(title: "Filter Stations", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Show All", style: .default) { _ in
            self.viewModel.applyFilter(.all)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "Available Only", style: .default) { _ in
            self.viewModel.applyFilter(.available)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "DC Fast Chargers", style: .default) { _ in
            self.viewModel.applyFilter(.dcFast)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "AC Chargers", style: .default) { _ in
            self.viewModel.applyFilter(.ac)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "Sort by Distance", style: .default) { _ in
            self.viewModel.applyFilter(.sortedByDistance)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "Sort by Price", style: .default) { _ in
            self.viewModel.applyFilter(.sortedByPrice)
            self.clearSearchIfNeeded()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = filterButton
        }
        
        present(alert, animated: true)
    }
    
    
    func showMapOptions(
        from start: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D
    ) {
        let alert = UIAlertController(
            title: "Get Directions",
            message: "Choose map application",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "View in App", style: .default) { _ in
            MapNavigationHelper.open(
                mapApp: .inApp,
                from: start,
                to: destination
            ) {
                self.showRoute(from: start, to: destination)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Apple Maps", style: .default) { _ in
            MapNavigationHelper.open(
                mapApp: .appleMaps,
                from: start,
                to: destination
            )
        })
        
        if MapNavigationHelper.isGoogleMapsInstalled() {
            alert.addAction(UIAlertAction(title: "Google Maps", style: .default) { _ in
                MapNavigationHelper.open(
                    mapApp: .googleMaps,
                    from: start,
                    to: destination
                )
            })
        }
        
        if MapNavigationHelper.isWazeInstalled() {
            alert.addAction(UIAlertAction(title: "Waze", style: .default) { _ in
                MapNavigationHelper.open(
                    mapApp: .waze,
                    from: start,
                    to: destination
                )
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // iPad fix
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(
                x: self.view.bounds.midX,
                y: self.view.bounds.midY,
                width: 0,
                height: 0
            )
            popover.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EVMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let observableVM = viewModel as? EVStationListViewModel {
            return observableVM.selectedStation?.connectors.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlugTypesTVC", for: indexPath) as? PlugTypesTVC,
              let observableVM = viewModel as? EVStationListViewModel,
              let connector = observableVM.selectedStation?.connectors[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: connector)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - MKMapViewDelegate
extension EVMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation.title == "You are here" {
            let identifier = "CurrentLocation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                if let markerView = annotationView as? MKMarkerAnnotationView {
                    markerView.markerTintColor = .systemBlue
                    markerView.glyphImage = UIImage(systemName: "location.fill")
                    markerView.animatesWhenAdded = true
                }
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        if routeAnnotations.contains(where: { $0 === annotation }) {
            let identifier = "RoutePoint"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            if annotation.title == "Your Location" {
                annotationView?.markerTintColor = .systemBlue
                annotationView?.glyphImage = UIImage(systemName: "location.fill")
            } else if annotation.title == "Destination" {
                annotationView?.markerTintColor = .systemGreen
                annotationView?.glyphImage = UIImage(systemName: "flag.fill")
            } else {
                annotationView?.markerTintColor = .systemOrange
                annotationView?.glyphImage = UIImage(systemName: "bolt.car.fill")
            }
            
            annotationView?.canShowCallout = true
            return annotationView
        }
        
        guard let pointAnnotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        guard let observableVM = viewModel as? EVStationListViewModel,
              let annotationVM = observableVM.annotations.first(where: {
                  $0.coordinate.latitude == pointAnnotation.coordinate.latitude &&
                  $0.coordinate.longitude == pointAnnotation.coordinate.longitude
              }) else {
            return nil
        }
        
        let identifier = "EVStationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        // Check if this annotation is in search results
        let isSearchResult = searchResults.contains(where: {
            $0.stationId == annotationVM.stationId
        })
        
        if isSearching && isSearchResult {
            // Highlight search results with a different color
            annotationView?.image = createHighlightedAnnotationImage(for: annotationVM)
        } else {
            annotationView?.image = createAnnotationImage(for: annotationVM)
        }
        
        if annotationVM.availablePorts > 0 {
            annotationView = addPortCountBadge(to: annotationView, count: annotationVM.availablePorts)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation,
              annotation is MKUserLocation == false,
              annotation.title != "You are here",
              let observableVM = viewModel as? EVStationListViewModel else { return }
        
        if let annotationVM = observableVM.annotations.first(where: {
            $0.coordinate.latitude == annotation.coordinate.latitude &&
            $0.coordinate.longitude == annotation.coordinate.longitude
        }) {
            observableVM.selectStation(withId: annotationVM.stationId)
            
            UIView.animate(withDuration: 0.2, animations: {
                view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    view.transform = .identity
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            print("MapView updated user location: \(location.coordinate)")
            currentUserLocation = location
            
            if shouldCenterOnUserLocation {
                centerMapOnUserLocation(at: location.coordinate)
                shouldCenterOnUserLocation = false
            }
            
            if !isUserLocationInitialized {
                isUserLocationInitialized = true
            }
        }
    }
    
    private func createAnnotationImage(for annotationVM: EVStationAnnotationViewModel) -> UIImage? {
        let pinSize = CGSize(width: 40, height: 50)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let symbol = UIImage(systemName: annotationVM.chargerSymbol, withConfiguration: symbolConfig)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        return createLocationPinImage(color: annotationVM.annotationColor, symbol: symbol, size: pinSize)
    }
    
    private func createHighlightedAnnotationImage(for annotationVM: EVStationAnnotationViewModel) -> UIImage? {
        let pinSize = CGSize(width: 45, height: 55) // Slightly larger for highlighted
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let symbol = UIImage(systemName: annotationVM.chargerSymbol, withConfiguration: symbolConfig)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        
        return createLocationPinImage(color: .systemOrange, symbol: symbol, size: pinSize)
    }
    
    private func createLocationPinImage(color: UIColor, symbol: UIImage?, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { context in
            let pinPath = UIBezierPath()
            let topRect = CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.7)
            let cornerRadius: CGFloat = 10
            pinPath.append(UIBezierPath(roundedRect: topRect, cornerRadius: cornerRadius))
            
            let triangleHeight = size.height * 0.3
            let triangleWidth = size.width * 0.4
            let trianglePath = UIBezierPath()
            trianglePath.move(to: CGPoint(x: size.width / 2 - triangleWidth / 2, y: size.height * 0.7))
            trianglePath.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            trianglePath.addLine(to: CGPoint(x: size.width / 2 + triangleWidth / 2, y: size.height * 0.7))
            trianglePath.close()
            pinPath.append(trianglePath)
            
            color.setFill()
            pinPath.fill()
            
            UIColor.white.setStroke()
            context.cgContext.setLineWidth(2)
            pinPath.lineWidth = 2
            pinPath.stroke()
            
            if let symbol = symbol {
                let symbolSize = CGSize(width: 20, height: 20)
                let symbolRect = CGRect(
                    x: (size.width - symbolSize.width) / 2,
                    y: (size.height * 0.7 - symbolSize.height) / 2,
                    width: symbolSize.width,
                    height: symbolSize.height
                )
                symbol.draw(in: symbolRect)
            }
        }
    }
    
    private func addPortCountBadge(to annotationView: MKAnnotationView?, count: Int) -> MKAnnotationView? {
        guard let annotationView = annotationView, count > 0 else { return annotationView }
        
        let badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        badgeLabel.text = "\(count)"
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        badgeLabel.backgroundColor = .systemBlue
        badgeLabel.layer.cornerRadius = 11
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.borderColor = UIColor.white.cgColor
        badgeLabel.layer.borderWidth = 2
        badgeLabel.frame.origin = CGPoint(x: 25, y: -5)
        annotationView.subviews.forEach { $0.removeFromSuperview() }
        annotationView.addSubview(badgeLabel)
        
        return annotationView
    }
}

// MARK: - UISearchBarDelegate
extension EVMapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Perform search as user types (with debounce if needed)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: searchBar)
        perform(#selector(performSearch), with: searchBar, afterDelay: 0.5)
    }
    
    @objc private func performSearch(_ searchBar: UISearchBar) {
        guard let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchStations(with: query)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchStations(with: query)
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true {
            searchBar.showsCancelButton = false
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension EVMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("LocationManager did update location: \(location.coordinate)")
        currentUserLocation = location
        
        if shouldCenterOnUserLocation {
            centerMapOnUserLocation(at: location.coordinate)
            shouldCenterOnUserLocation = false
        }
        
        if !isUserLocationInitialized {
            isUserLocationInitialized = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location authorization changed to: \(status.rawValue)")
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            mapView.showsUserLocation = true
            
            if let location = manager.location {
                print("Got initial location after authorization: \(location.coordinate)")
                currentUserLocation = location
                
                if shouldCenterOnUserLocation {
                    centerMapOnUserLocation(at: location.coordinate)
                    shouldCenterOnUserLocation = false
                }
                
                if !isUserLocationInitialized {
                    isUserLocationInitialized = true
                }
            }
            
        case .denied, .restricted:
            if shouldCenterOnUserLocation {
                showLocationPermissionAlert()
                shouldCenterOnUserLocation = false
            }
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        
        if shouldCenterOnUserLocation {
            showAlert(title: "Location Error", message: "Unable to get your location. Please check your settings.")
            shouldCenterOnUserLocation = false
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension EVMapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - Extensions
extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                            count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

extension MKCoordinateRegion {
    init(mapRect: MKMapRect) {
        let center = CLLocationCoordinate2D(
            latitude: mapRect.midY,
            longitude: mapRect.midX
        )
        let span = MKCoordinateSpan(
            latitudeDelta: mapRect.height,
            longitudeDelta: mapRect.width
        )
        self.init(center: center, span: span)
    }
    
    
}


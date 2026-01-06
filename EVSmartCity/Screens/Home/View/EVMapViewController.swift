//
//  EVMapViewController.swift
//  EVSmartCity
//
//  Created by Toqsoft on 05/01/26.
//

import UIKit
import MapKit
import Combine

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
    
    private var viewModel = EVStationViewModel()
    private var mapManager = MapManager()
    private var cancellables = Set<AnyCancellable>()
    private var stationDetailsViewModel: StationDetailsViewModel?
    
    private let minZoomLevel: Double = 0.002
    private let maxZoomLevel: Double = 50.0
    private let zoomFactor: Double = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpMethods()
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
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        showFilterOptions()
    }
        
}

extension EVMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationDetailsViewModel?.connectors.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlugTypesTVC", for: indexPath) as? PlugTypesTVC,
              let connectorVM = stationDetailsViewModel?.connectors[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: connectorVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EVMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let stationAnnotation = annotation as? EVStationAnnotation else {
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
        
        annotationView?.image = getLocationPinImage(for: stationAnnotation.station)
        
        if stationAnnotation.station.availablePorts > 0 {
            annotationView = addPortCountBadge(to: annotationView, count: stationAnnotation.station.availablePorts)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let stationAnnotation = view.annotation as? EVStationAnnotation else { return }
        viewModel.selectStation(stationAnnotation.station)
        
        UIView.animate(withDuration: 0.2, animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                view.transform = CGAffineTransform.identity
            }
        }
    }
    
}

extension EVMapViewController {
    private func getLocationPinImage(for station: EVStation) -> UIImage? {
        let pinSize = CGSize(width: 40, height: 50)
        let pinColor = getPinColor(for: station)
        let chargerSymbol = getChargerSymbol(for: station)
        return createLocationPinImage(color: pinColor, symbol: chargerSymbol, size: pinSize)
    }
    
    private func getPinColor(for station: EVStation) -> UIColor {
        switch station.status {
        case "Available":
            return ColorManager.shared.systemGreen
        case "Busy":
            return ColorManager.shared.systemOrange
        default:
            return ColorManager.shared.systemRed
        }
    }
    
    private func getChargerSymbol(for station: EVStation) -> UIImage? {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        
        if station.chargerTypes.contains("DC") && station.chargerTypes.contains("AC") {
            return UIImage(systemName: "bolt.horizontal.circle.fill", withConfiguration: symbolConfig)?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
        } else if station.chargerTypes.contains("DC") {
            return UIImage(systemName: "bolt.fill", withConfiguration: symbolConfig)?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
        } else {
            return UIImage(systemName: "bolt.horizontal.fill", withConfiguration: symbolConfig)?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
        }
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
            
            context.cgContext.setShadow(offset: CGSize(width: 0, height: 2), blur: 3, color: UIColor.black.withAlphaComponent(0.3).cgColor)
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

extension EVMapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension EVMapViewController {
    
    func setUpMethods() {
        setupUI()
        setupBindings()
        setupTableView()
        setupMapView()
        setupZoomButtons()
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
    }
    
    @objc private func handleStationDetailsTap(_ gesture: UITapGestureRecognizer) {
        guard let selectedStation = viewModel.selectedStation,
              stationDetailsView.isHidden == false else { return }
        
        navigateToStationDetails(station: selectedStation)
    }
    
    private func navigateToStationDetails(station: EVStation) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "ChargingStationDetailsVC") as! ChargingStationDetailsVC
        detailsVC.selectedStation = station
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func setupZoomButtons() {
        plusButton.layer.cornerRadius = 8
        plusButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        plusButton.layer.borderColor = UIColor.white.cgColor
        plusButton.layer.borderWidth = 0.5
        plusButton.layer.masksToBounds = true

        minusButton.layer.cornerRadius = 8
        minusButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        minusButton.layer.borderColor = UIColor.white.cgColor
        minusButton.layer.borderWidth = 0.5
        minusButton.layer.masksToBounds = true

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTapGesture)
    }
    
    private func setupBindings() {
        viewModel.$evStations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stations in
                guard let self = self else { return }
                self.updateMapAnnotations()
                self.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.loadingIndicator.isHidden = !isLoading
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    self.errorLabel.text = error
                    self.errorLabel.isHidden = false
                } else {
                    self.errorLabel.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        viewModel.$selectedStation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] station in
                guard let self = self else { return }
                if let station = station {
                    self.showStationDetails(station)
                } else {
                    self.hideStationDetails()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        plugTypesTableView.register(UINib(nibName: "PlugTypesTVC", bundle: nil), forCellReuseIdentifier: "PlugTypesTVC")
        plugTypesTableView.rowHeight = UITableView.automaticDimension
        plugTypesTableView.estimatedRowHeight = 40
        plugTypesTableView.isScrollEnabled = false
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = false
        mapView.setRegion(mapManager.region, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
    }
    
    private func zoomMap(zoomIn: Bool) {
        let currentRegion = mapView.region
        
        let newLatitudeDelta = zoomIn ?
            currentRegion.span.latitudeDelta / zoomFactor :
            currentRegion.span.latitudeDelta * zoomFactor
        
        let newLongitudeDelta = zoomIn ?
            currentRegion.span.longitudeDelta / zoomFactor :
            currentRegion.span.longitudeDelta * zoomFactor
        
        let clampedLatDelta = max(minZoomLevel, min(maxZoomLevel, newLatitudeDelta))
        let clampedLonDelta = max(minZoomLevel, min(maxZoomLevel, newLongitudeDelta))
        
        let newSpan = MKCoordinateSpan(latitudeDelta: clampedLatDelta, longitudeDelta: clampedLonDelta)
        let newRegion = MKCoordinateRegion(center: currentRegion.center, span: newSpan)
        
        UIView.animate(withDuration: 0.3) {
            self.mapView.setRegion(newRegion, animated: true)
        }
        
        provideHapticFeedback()
    }
    
    private func provideHapticFeedback() {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    private func updateZoomButtonStates() {
        let currentSpan = mapView.region.span.latitudeDelta
        
        plusButton.isEnabled = currentSpan > minZoomLevel
        plusButton.alpha = plusButton.isEnabled ? 1.0 : 0.5
        
        minusButton.isEnabled = currentSpan < maxZoomLevel
        minusButton.alpha = minusButton.isEnabled ? 1.0 : 0.5
    }
        
    @objc private func handleDoubleTapGesture(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        zoomToLocation(latitude: coordinate.latitude, longitude: coordinate.longitude, zoomLevel: 0.01)
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
        }
    }

    private func zoomToLocation(latitude: Double, longitude: Double, zoomLevel: Double = 0.05) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        UIView.animate(withDuration: 0.5) {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    private func zoomToFitAllStations() {
        let annotations = mapView.annotations
        guard !annotations.isEmpty else { return }
        
        var minLat = annotations[0].coordinate.latitude
        var maxLat = annotations[0].coordinate.latitude
        var minLon = annotations[0].coordinate.longitude
        var maxLon = annotations[0].coordinate.longitude
        
        for annotation in annotations {
            minLat = min(minLat, annotation.coordinate.latitude)
            maxLat = max(maxLat, annotation.coordinate.latitude)
            minLon = min(minLon, annotation.coordinate.longitude)
            maxLon = max(maxLon, annotation.coordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.3,
            longitudeDelta: (maxLon - minLon) * 1.3
        )
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        UIView.animate(withDuration: 0.5) {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    private func updateMapAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = viewModel.getStationAnnotations()
        mapView.addAnnotations(annotations)
        if !annotations.isEmpty {
            zoomToFitAllStations()
        }
    }
    
    private func showStationDetails(_ station: EVStation) {
        stationDetailsViewModel = StationDetailsViewModel(station: station)
        updateStationDetailsUI()
        priceLabel.isHidden = false
        priceLabel.alpha = 0
        
        stationDetailsView.alpha = 0
        stationDetailsView.isHidden = false
        updateStationDetailsHeight()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.stationDetailsView.alpha = 1
            self.priceLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateStationDetailsUI() {
        guard let viewModel = stationDetailsViewModel else { return }
        
        stationNameLabel.text = viewModel.stationName
        distanceLabel.text = viewModel.distanceText
        
        priceLabel.isHidden = false
        priceLabel.text = viewModel.pricingText
        priceLabel.textColor = .systemBlue
        priceLabel.layer.cornerRadius = 5
        priceLabel.layer.masksToBounds = true
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        if let plugScore = self.viewModel.calculatePlugScore(for: viewModel.station) {
            plugScoreLabel.isHidden = false
            plugScoreLabel.text = "Plug Score: \(plugScore)/10"
            plugScoreLabel.textColor = plugScore >= 7 ? .systemGreen : (plugScore >= 4 ? .systemOrange : .systemRed)
            plugScoreLabel.layer.cornerRadius = 5
            plugScoreLabel.layer.masksToBounds = true
            
            let backgroundColor = plugScore >= 7 ? UIColor.systemGreen.withAlphaComponent(0.1) :
                                 (plugScore >= 4 ? UIColor.systemOrange.withAlphaComponent(0.1) :
                                  UIColor.systemRed.withAlphaComponent(0.1))
            plugScoreLabel.backgroundColor = backgroundColor
        } else {
            plugScoreLabel.isHidden = true
        }
        
        plugTypesTableView.reloadData()
        
        DispatchQueue.main.async {
            self.updateStationDetailsHeight()
        }
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
    
    private func updateStationDetailsHeight() {
        guard let viewModel = stationDetailsViewModel else { return }
        
        let rowHeight: CGFloat = 40
        let numberOfRows = viewModel.connectors.count
        let tableHeight = CGFloat(numberOfRows) * rowHeight
        let minTableHeight: CGFloat = 0
        let maxTableHeight: CGFloat = 200
        let clampedTableHeight = min(maxTableHeight, max(minTableHeight, tableHeight))
        let baseHeight: CGFloat = 100
        let totalHeight = baseHeight + clampedTableHeight
        UIView.animate(withDuration: 0.3) {
            self.tableViewheightConstraint.constant = clampedTableHeight
            self.stationDetailsViewHeightConstraint.constant = totalHeight
            self.view.layoutIfNeeded()
        }
    }
    
    private func showFilterOptions() {
        let alert = UIAlertController(title: "Filter Stations", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Show All", style: .default, handler: { _ in
            self.updateMapAnnotations()
        }))
        
        alert.addAction(UIAlertAction(title: "Available Only", style: .default, handler: { _ in
            let availableStations = self.viewModel.evStations.filter { $0.status == "Available" }
            self.showFilteredStations(availableStations)
        }))
        
        alert.addAction(UIAlertAction(title: "DC Fast Chargers", style: .default, handler: { _ in
            let dcStations = self.viewModel.filterStationsByChargerType("DC")
            self.showFilteredStations(dcStations)
        }))
        
        alert.addAction(UIAlertAction(title: "AC Chargers", style: .default, handler: { _ in
            let acStations = self.viewModel.filterStationsByChargerType("AC")
            self.showFilteredStations(acStations)
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by Distance", style: .default, handler: { _ in
            let sortedStations = self.viewModel.getStationsSortedByDistance()
            self.showFilteredStations(sortedStations)
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by Price", style: .default, handler: { _ in
            let sortedStations = self.viewModel.getStationsSortedByPrice()
            self.showFilteredStations(sortedStations)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = filterButton
        }
        
        present(alert, animated: true)
    }
    
    private func showFilteredStations(_ stations: [EVStation]) {
        let annotations = stations.map { EVStationAnnotation(station: $0) }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
        if !annotations.isEmpty {
            zoomToFitAllStations()
        }
    }
}

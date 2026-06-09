//
//  StationsListVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/06/26.
//

protocol StationsListVCDelegate: AnyObject {
    func stationsListVCDidDismiss()
    func stationsListVCListButtonTapped()
}

import UIKit

class StationsListVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchRadiusLabel: UILabel!
    @IBOutlet weak var distanceRadiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var stationsListTableView: UITableView!
    @IBOutlet weak var mapbutton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var tableviewHeightConstraint: NSLayoutConstraint!
    
    let chargingStations: [ChargingStation] = [
        ChargingStation(stationName: "Riyadh Front Supercharger",operatorName: "Electromin",distanceKm: 1.2,distanceMin: 5,
            reliabilityScore: 94,availability: Availability(status: "3 of 6 free", freeSlots: 3, totalSlots: 6),
            connectorTypes: [.ccs2, .type2],powerKw: 150,powerType: .fast,waitTime: "No wait",rating: 4.8,reviewCount: 124,
            isOffline: false,
            amenities: [
                Amenity(id: "1", name: "Restroom", iconName: "toilet.fill", isAvailable: true),
                Amenity(id: "2", name: "Cafe", iconName: "cup.and.saucer.fill", isAvailable: true),
                Amenity(id: "3", name: "WiFi", iconName: "wifi", isAvailable: true),
                Amenity(id: "4", name: "Covered Parking", iconName: "parkingsign.circle", isAvailable: true),
                Amenity(id: "5", name: "Restaurant", iconName: "fork.knife", isAvailable: true)
            ]
        ),
        ChargingStation(stationName: "KAFD Charging Hub",operatorName: "EVox",distanceKm: 3.4,distanceMin: 12,
            reliabilityScore: 82,availability: Availability(status: "0 of 4 free", freeSlots: 0, totalSlots: 4),
            connectorTypes: [.type2],powerKw: 22,powerType: .ac,waitTime: "~12 min wait",rating: 4.5,reviewCount: 89,
            isOffline: false,
            amenities: [
                Amenity(id: "1", name: "Covered Parking", iconName: "parkingsign.circle", isAvailable: true),
                Amenity(id: "2", name: "Waiting Lounge", iconName: "sofa.fill", isAvailable: true),
                Amenity(id: "3", name: "Free WiFi", iconName: "wifi", isAvailable: true),
                Amenity(id: "4", name: "Coffee", iconName: "cup.and.saucer.fill", isAvailable: true),
                Amenity(id: "5", name: "Restaurant", iconName: "fork.knife", isAvailable: true)
            ]
        ),
        ChargingStation(stationName: "Boulevard World Chargers",operatorName: "GreenWay",distanceKm: 5.1,distanceMin: 18,
            reliabilityScore: 61,availability: Availability(status: "Maintenance", freeSlots: nil, totalSlots: nil),
            connectorTypes: [.chademo, .ccs2],powerKw: 50,powerType: nil,waitTime: "Offline",rating: 3.9,
            reviewCount: 42,isOffline: true,
            amenities: [
                Amenity(id: "1", name: "Restaurant", iconName: "fork.knife", isAvailable: true),
                Amenity(id: "2", name: "Shop", iconName: "bag.fill", isAvailable: true),
                Amenity(id: "3", name: "Parking", iconName: "parkingsign.circle", isAvailable: true),
                Amenity(id: "4", name: "Good Lighting", iconName: "lightbulb.fill", isAvailable: false)
            ]
        )
    ]
    
    weak var delegate: StationsListVCDelegate?
    private var selectedType: MapsList = .list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
    }
    
    @IBAction func mapButtonAction(_ sender: Any) {
        selectedType = .maps
        selectMapButton()
        delegate?.stationsListVCDidDismiss()
        self.dismiss(animated: true)
    }
    
    @IBAction func listButtonAction(_ sender: Any) {
        selectedType = .list
        selectListButton()
        delegate?.stationsListVCListButtonTapped()
    }
}

extension StationsListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chargingStations.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationsListTVC") as! StationsListTVC
        let station = chargingStations[indexPath.row]
        cell.configure(with: station)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}


extension StationsListVC {
    func setUpUI() {
        setUpTableView()
        customizeSegmentControl()
        setupRadiusSlider()
        selectListButton()
    }
    
    func selectMapButton() {
        mapbutton.backgroundColor = UIColor(hex: "#379D67")
        mapbutton.tintColor = .white
        mapbutton.setTitleColor(.white, for: .normal)
        listButton.backgroundColor = .clear
        listButton.tintColor = .darkGray
        listButton.setTitleColor(.darkGray, for: .normal)
    }
    
    func selectListButton() {
        listButton.backgroundColor = UIColor(hex: "#379D67")
        listButton.tintColor = .white
        listButton.setTitleColor(.white, for: .normal)
        mapbutton.backgroundColor = .clear
        mapbutton.tintColor = .darkGray
        mapbutton.setTitleColor(.darkGray, for: .normal)
    }
    
    func setUpTableView() {
        stationsListTableView.register(UINib(nibName: "StationsListTVC", bundle: nil), forCellReuseIdentifier: "StationsListTVC")
        stationsListTableView.isScrollEnabled = false
        stationsListTableView.showsVerticalScrollIndicator = false
        stationsListTableView.showsHorizontalScrollIndicator = false
    }
    
    private func updateTableViewHeight() {
        let rowHeight: CGFloat = 260
        let totalHeight = CGFloat(chargingStations.count) * rowHeight
        tableviewHeightConstraint.constant = totalHeight
        self.view.layoutIfNeeded()
    }
    
    private func customizeSegmentControl() {
        segmentControl.customizeAppearance()
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func setupRadiusSlider() {
        radiusSlider.minimumValue = 0
        radiusSlider.maximumValue = 50
        radiusSlider.value = 10
        radiusSlider.tintColor = UIColor(hex: "#059669")
        
        let thumbImage = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(hex: "#059669"), renderingMode: .alwaysOriginal)
        radiusSlider.setThumbImage(thumbImage, for: .normal)
        radiusSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        updateRadiusLabel()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        sender.value = Float(roundedValue)
        updateRadiusLabel()
        filterStationsByRadius(radius: roundedValue)
    }
    
    private func updateRadiusLabel() {
        let value = Int(radiusSlider.value)
        distanceRadiusLabel.text = "\(value) km"
        searchRadiusLabel.text = "Search Radius"
    }
    
    private func filterStationsByRadius(radius: Int) {
        let filtered = chargingStations.filter { station in
            return station.distanceKm <= Double(radius)
        }
    }
}

extension UISegmentedControl {
    func customizeAppearance() {
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#4B5563"),
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        setTitleTextAttributes(normalAttributes, for: .normal)
        setTitleTextAttributes(selectedAttributes, for: .selected)
        
        selectedSegmentTintColor = UIColor(hex: "#059669")
        backgroundColor = .clear
        layer.borderWidth = 0
    }
}

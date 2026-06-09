//
//  FavouritesVC.swift
//  EVSmartCity
//
//  Created by Hitman on 02/06/26.
//

enum FavouriteType {
    case stations
    case routes
}

import UIKit

class FavouritesVC: UIViewController {

    @IBOutlet weak var backView: UIButton!
    @IBOutlet weak var favouritesTitleLabel: UILabel!
    @IBOutlet weak var heartImgView: UIImageView!
    @IBOutlet weak var yourSavedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var stationsButton: UIButton!
    @IBOutlet weak var routesButton: UIButton!
    
    var selectedType: FavouriteType = .stations
    
    let stations: [FavouriteChargingStationModel] = [
        FavouriteChargingStationModel(stationName: "Al Nakheel Station",stationAddress: "King Fahd Rd, Riyadh 12312",distance: "2.4 km away",stationType: "DC Fast", availability: "24/7"),
        FavouriteChargingStationModel(stationName: "ROSHN Front Station",stationAddress: "Tahlia St, Riyadh 12311",distance: "4.8 km away",stationType: "AC", availability: "24/7"),
        FavouriteChargingStationModel(stationName: "Al Qasr Station",stationAddress: "Olaya St, Riyadh 12212",distance: "7.6 km away",stationType: "DC Fast", availability: "24/7"),
        FavouriteChargingStationModel(stationName: "IKEA Station",stationAddress: "North Ring Rd, Riyadh 11465",distance: "9.1 km away",stationType: "AC", availability: "06:00 AM - 12:00 AM"),
        FavouriteChargingStationModel(stationName: "Granada Mall Station",stationAddress: "Eastern Ring Rd, Riyadh 13241",distance: "11.3 km away",stationType: "DC Fast", availability: "24/7")
    ]
    
    let routes: [FavouriteRouteModel] = [
        FavouriteRouteModel(title: "Home → Office",currentAddress: "Al Nakheel District, Riyadh",destinationAddress: "King Fahd Rd, Riyadh",stops: "2 Stops",time: "28 min",distance: "22.4 km"),
        FavouriteRouteModel(title: "Home → Dad's Home",currentAddress: "Al Nakheel District, Riyadh",destinationAddress: "Al Yasmin, Riyadh",stops: "1 Stop",time: "35 min",distance: "26.7 km"),
        FavouriteRouteModel(title: "Riyadh → Dammam",currentAddress: "Al Nakheel District, Riyadh",destinationAddress: "Dammam Corniche, Dammam",stops: "3 Stops",time: "1 hr 45 min",distance: "39.9 km"),
        FavouriteRouteModel(title: "Gym → Home",currentAddress: "Gym Street, Riyadh",destinationAddress: "Al Nakheel District, Riyadh",stops: "1 Stop",time: "18 min",distance: "11.2 km")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func backViewButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func stationsButtonAction(_ sender: Any) {
        selectedType = .stations
        selectStationsButton()
        updateFavouritesUI()
        favouritesTableView.reloadData()
    }
    
    @IBAction func routesButtonAction(_ sender: Any) {
        selectedType = .routes
        selectRoutesButton()
        updateFavouritesUI()
        favouritesTableView.reloadData()
    }
}


extension FavouritesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedType {
        case .stations:
            return stations.count
        case .routes:
            return routes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedType {
        case .stations:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteStationsTVC",for: indexPath) as! FavouriteStationsTVC
            let stationDetails = stations[indexPath.row]
            cell.configure(stationsdata: stationDetails)
            return cell
        case .routes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoutesTVC",for: indexPath) as! RoutesTVC
            let routeDetails = routes[indexPath.row]
            cell.configure(with: routeDetails)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedType {
        case .stations:
            return 130
        case .routes:
            return 138
        }
    }
}

extension FavouritesVC {
    func setUpUI() {
        setUpTableView()
        selectedType = .stations
        selectStationsButton()
        updateFavouritesUI()
    }
    
    func setUpTableView() {
        favouritesTableView.register(UINib(nibName: "FavouriteStationsTVC", bundle: nil), forCellReuseIdentifier: "FavouriteStationsTVC")
        favouritesTableView.register(UINib(nibName: "RoutesTVC", bundle: nil), forCellReuseIdentifier: "RoutesTVC")
        favouritesTableView.showsVerticalScrollIndicator = false
        favouritesTableView.showsHorizontalScrollIndicator = false
    }
    
    func selectStationsButton() {
        stationsButton.backgroundColor = UIColor(hex: "#379D67")
        stationsButton.tintColor = .white
        stationsButton.setTitleColor(.white, for: .normal)
        routesButton.backgroundColor = .clear
        routesButton.tintColor = .darkGray
        routesButton.setTitleColor(.darkGray, for: .normal)
    }

    func selectRoutesButton() {
        routesButton.backgroundColor = UIColor(hex: "#379D67")
        routesButton.tintColor = .white
        routesButton.setTitleColor(.white, for: .normal)
        stationsButton.backgroundColor = .clear
        stationsButton.tintColor = .darkGray
        stationsButton.setTitleColor(.darkGray, for: .normal)
    }
    
    func updateFavouritesUI() {
        switch selectedType {
        case .stations:
            yourSavedLabel.text = "Your saved stations"
            descriptionLabel.text = "Quick access to the places you charge most"
            heartImgView.image = UIImage(systemName: "heart")
        case .routes:
            yourSavedLabel.text = "Your saved routes"
            descriptionLabel.text = "Quick access to your frequent journeys"
            heartImgView.image = UIImage(systemName: "safari")
        }
    }
}

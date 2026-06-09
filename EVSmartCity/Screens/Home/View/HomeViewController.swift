//
//  HomeViewController.swift
//  EVSmartCity
//
//  Created by ToqSoft on 01/12/25.

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var weatherDetailsCollectionView: UICollectionView!
    @IBOutlet weak var smartTipView: UIView!
    @IBOutlet weak var smartTipLabel: UILabel!
    @IBOutlet weak var chargeAfterTimeLabel: UILabel!
    @IBOutlet weak var leftMenuButton: UIBarButtonItem!
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    @IBOutlet weak var homeFeatureCollectionView: UICollectionView!
    @IBOutlet weak var carStatusView: UIView!
    @IBOutlet weak var myCarStatusButton: UIButton!
    @IBOutlet weak var fullDetailsbutton: UIButton!
    @IBOutlet weak var batterypercentlabel: UILabel!
    @IBOutlet weak var psiLabel: UILabel!
    @IBOutlet weak var typePresureLabel: UILabel!
    @IBOutlet weak var batteryHealthPercentLabel: UILabel!
    @IBOutlet weak var batteryHealthlabel: UILabel!
    @IBOutlet weak var distanceKMLabel: UILabel!
    @IBOutlet weak var totalKMLabel: UILabel!
    @IBOutlet weak var allSystemsOptimalButton: UIButton!
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var currentRatesSARLabel: UILabel!
    @IBOutlet weak var allRatesButton: UIButton!
    @IBOutlet weak var dcFastButton: UIButton!
    @IBOutlet weak var dcRateLabel: UILabel!
    @IBOutlet weak var sarDCLabel: UILabel!
    @IBOutlet weak var perKWHDCLabel: UILabel!
    @IBOutlet weak var fastInstantLabel: UILabel!
    @IBOutlet weak var acStandardButton: UIButton!
    @IBOutlet weak var rateACLabel: UILabel!
    @IBOutlet weak var sarACLabel: UILabel!
    @IBOutlet weak var perKWHACLabel: UILabel!
    @IBOutlet weak var standardLabel: UILabel!
    @IBOutlet weak var nearByChargersLabel: UILabel!
    @IBOutlet weak var fullmapButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var chargingStationsTableView: UITableView!
    @IBOutlet weak var chargingStationsTableViewHeightConstraint: NSLayoutConstraint!
    
    
    let items = ["Weather", "Battery"]
    
    let quickActions: [HomeFeaturesModel] = [
        HomeFeaturesModel(title: "Find Charger", imageName: "ev.plug.ac.type.1"), // powerplug
        HomeFeaturesModel(title: "Plan Trip", imageName: "map.circle.fill"),
        HomeFeaturesModel(title: "Favourites", imageName: "heart"),
        HomeFeaturesModel(title: "History", imageName: "list.clipboard")
    ]
    
    let chargingStations: [ChargingStationModel] = [
        ChargingStationModel(stationImage: "bolt.fill",stationName: "EVIQ — Al Olaya Hub",stationType: "DC Fast",
            powerOutput: "150 kW",plugs: "8 plugs",status: "Open",distance: "1.2 km",availableSlots: "6 free",
            availableColor: "systemGreen"),
        ChargingStationModel(stationImage: "powerplug.fill",stationName: "Star Charger — Tahlia St",stationType: "AC Standard",powerOutput: "22 kW",plugs: "4 plugs",status: "Open",distance: "2.8 km",availableSlots: "2 free",
            availableColor: "systemGreen"),
        ChargingStationModel(stationImage: "bolt.badge.clock",stationName: "Tesla SC — Kingdom Mall",stationType: "Supercharger",powerOutput: "250 kW",plugs: "Tesla only",status: "Busy",distance: "3.5 km",availableSlots: "1 free",availableColor: "systemOrange"),
        ChargingStationModel(stationImage: "bolt.fill",stationName: "Aramco EV — Corniche",stationType: "DC Fast",
            powerOutput: "100 kW",plugs: "6 plugs",status: "Open",distance: "4.1 km",availableSlots: "4 free",
            availableColor: "systemGreen"),
        ChargingStationModel(stationImage: "bolt.badge.clock",stationName: "Tesla SC — Kingdom Mall",stationType: "Supercharger",powerOutput: "250 kW",plugs: "Tesla only",status: "Busy",distance: "3.5 km",availableSlots: "1 free",availableColor: "systemOrange"),
        ChargingStationModel(stationImage: "bolt.fill",stationName: "Aramco EV — Corniche",stationType: "DC Fast",
            powerOutput: "100 kW",plugs: "6 plugs",status: "Open",distance: "4.1 km",availableSlots: "4 free",
            availableColor: "systemGreen")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chargingStationsTableViewHeightConstraint.constant = chargingStationsTableView.contentSize.height + 20
    }

    @IBAction func leftMenuButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "LeftMenu", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        storyboard.modalPresentationStyle = .overFullScreen
        self.present(storyboard, animated: true)
    }

    @IBAction func notificationButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func fullDetailsButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "CarDetailsVC") as! CarDetailsVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func allRatesButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "CurrentRatesVC") as! CurrentRatesVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func viewFullmapbuttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "EVMapViewController") as! EVMapViewController
        weatherDetailsVC.modalPresentationStyle = .fullScreen
        present(weatherDetailsVC, animated: true)
    }
    
    
}

// MARK: - Collection View
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weatherDetailsCollectionView {
            return items.count
        } else if collectionView == homeFeatureCollectionView {
            return quickActions.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weatherDetailsCollectionView {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailsCVC",for: indexPath) as! WeatherDetailsCVC
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BatteryLevelCVC",for: indexPath) as! BatteryLevelCVC
                return cell
            }
        } else if collectionView == homeFeatureCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeFeatureCVC",for: indexPath) as! homeFeatureCVC
            let homeFeatures = quickActions[indexPath.row]
            cell.configure(with: homeFeatures)
            return cell
        }
        return UICollectionViewCell()
        
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == weatherDetailsCollectionView {
            let width = (collectionView.frame.width - 10) / 2
            return CGSize(width: width, height: collectionView.frame.height)
        } else if collectionView == homeFeatureCollectionView {
            let spacing: CGFloat = 10
            let totalSpacing = spacing * 3
            let width = (collectionView.frame.width - totalSpacing) / 4
            return CGSize(width: width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == weatherDetailsCollectionView {
            if indexPath.item == 0 {
                let storyboard = UIStoryboard(name: "Weather", bundle: nil)
                let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsVC") as! WeatherDetailsVC
                weatherDetailsVC.modalPresentationStyle = .fullScreen
                present(weatherDetailsVC, animated: true)
            }
        } else if collectionView == homeFeatureCollectionView {
            if indexPath.item == 0 {
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "EVMapViewController") as! EVMapViewController
                weatherDetailsVC.modalPresentationStyle = .fullScreen
                present(weatherDetailsVC, animated: true)
            } else if indexPath.item == 1 {
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "PlanTripViewController") as! PlanTripViewController
                weatherDetailsVC.modalPresentationStyle = .fullScreen
                present(weatherDetailsVC, animated: true)
            } else if indexPath.item == 2 {
                let storyboard = UIStoryboard(name: "Favourites", bundle: nil)
                let weatherDetailsVC = storyboard.instantiateViewController(withIdentifier: "FavouritesVC") as! FavouritesVC
                weatherDetailsVC.modalPresentationStyle = .fullScreen
                present(weatherDetailsVC, animated: true)
            }
        }
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == offersTableView {
            return 1
        } else if tableView == chargingStationsTableView {
            return chargingStations.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == offersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTVC") as! OffersTVC
            return cell
        } else if tableView == chargingStationsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyChargersTVC") as! NearbyChargersTVC
            let charging = chargingStations[indexPath.row]
            cell.configure(with: charging)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTVC") as! OffersTVC
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == offersTableView {
            return 74
        } else if tableView == chargingStationsTableView {
            return 80
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == offersTableView {
            let storyboard = UIStoryboard(name: "Offers", bundle: nil).instantiateViewController(withIdentifier: "OffersVC") as! OffersVC
            storyboard.modalPresentationStyle = .fullScreen
            present(storyboard, animated: true)
        }
    }
}

extension HomeViewController {
    func setUpUI() {
        setUpCollectionView()
        setUpTableView()
    }
    
    func setUpCollectionView() {
        weatherDetailsCollectionView.register(UINib(nibName: "WeatherDetailsCVC", bundle: nil),forCellWithReuseIdentifier: "WeatherDetailsCVC")

        weatherDetailsCollectionView.register(UINib(nibName: "BatteryLevelCVC", bundle: nil),forCellWithReuseIdentifier: "BatteryLevelCVC")
        if let layout = weatherDetailsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.estimatedItemSize = .zero
        }
        
        homeFeatureCollectionView.register(UINib(nibName: "homeFeatureCVC", bundle: nil), forCellWithReuseIdentifier: "homeFeatureCVC")
        if let layouts = homeFeatureCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
    }
    
    func setUpTableView() {
        offersTableView.register(UINib(nibName: "OffersTVC", bundle: nil), forCellReuseIdentifier: "OffersTVC")
        chargingStationsTableView.register(UINib(nibName: "NearbyChargersTVC", bundle: nil), forCellReuseIdentifier: "NearbyChargersTVC")
        chargingStationsTableView.isScrollEnabled = false
    }
}

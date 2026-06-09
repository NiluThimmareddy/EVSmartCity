//
//  StationsListTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 05/06/26.

import UIKit

class StationsListTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var boltImgView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationDistanceLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var reliableView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var shieldImgView: UIImageView!
    @IBOutlet weak var reliableLabel: UILabel!
    @IBOutlet weak var leafView: UIView!
    @IBOutlet weak var leafImgView: UIImageView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var insideColourView: UIView!
    @IBOutlet weak var availableChargersCountLabel: UILabel!
    @IBOutlet weak var pricePerKWHLabel: UILabel!
    @IBOutlet weak var waitView: UIView!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    @IBOutlet weak var kwView: UIView!
    @IBOutlet weak var boltColourImgView: UIImageView!
    @IBOutlet weak var oneFiftyKWFastLabel: UILabel!
    @IBOutlet weak var connectortypesCollectionView: UICollectionView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var amenitiesCollectionView: UICollectionView!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var navigateButton: UIButton!
    
    private var connectorTypes: [ConnectorsTypes] = []
    private var amenities: [Amenity] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func configure(with station: ChargingStation) {
        stationNameLabel.text = station.stationName
        stationDistanceLabel.text = "\(station.distanceKm) km away • \(station.distanceMin) min"
        reliableLabel.text = "\(station.reliabilityScore) Reliable"
        ratingsLabel.text = "\(station.rating) (\(station.reviewCount) reviews)"
        connectorTypes = station.connectorTypes
        configureAvailabilityText(with: station)
        
        if let waitTime = station.waitTime {
            waitingTimeLabel.text = waitTime
            waitView.isHidden = false
        } else {
            waitView.isHidden = true
        }
        
        if let kw = station.powerKw, let type = station.powerType {
            oneFiftyKWFastLabel.text = "\(kw) kW \(type.rawValue)"
        } else if let kw = station.powerKw {
            oneFiftyKWFastLabel.text = "\(kw) kW"
        } else {
            oneFiftyKWFastLabel.text = "N/A"
        }
        
        if station.isOffline {
            waitView.backgroundColor = UIColor(hex: "#F1F3F2")
            waitingTimeLabel.text = "Offline"
            availableChargersCountLabel.text = "Under Maintenance"
            availableChargersCountLabel.textColor = UIColor(hex: "#991B1B")
        }

        configureReliabilityColor(score: station.reliabilityScore)
        connectortypesCollectionView.reloadData()
        
        amenities = station.amenities
        amenitiesCollectionView.reloadData()
    }

    private func configureAvailabilityText(with station: ChargingStation) {
        if let free = station.availability.freeSlots, let total = station.availability.totalSlots {
            availableChargersCountLabel.text = "\(free) of \(total) free"
            
            switch free {
            case 0:
                availableChargersCountLabel.textColor = UIColor(hex: "#92400E")
                colorView.backgroundColor = UIColor(hex: "#F59E0B").withAlphaComponent(0.2)
                insideColourView.backgroundColor = UIColor(hex: "#92400E")
                kwView.backgroundColor = UIColor(hex: "#F59E0B").withAlphaComponent(0.2)
                boltColourImgView.tintColor = UIColor(hex: "#92400E")
                oneFiftyKWFastLabel.textColor = UIColor(hex: "#92400E")
                waitView.backgroundColor = UIColor(hex: "#F59E0B").withAlphaComponent(0.2)
                waitingTimeLabel.textColor = UIColor(hex: "#92400E")
                leafView.isHidden = true
            default:
                availableChargersCountLabel.textColor = UIColor(hex: "#059669")
                colorView.backgroundColor = UIColor(hex: "#059669").withAlphaComponent(0.2)
                insideColourView.backgroundColor = UIColor(hex: "#059669")
                kwView.backgroundColor = UIColor(hex: "#059669").withAlphaComponent(0.2)
                boltColourImgView.tintColor = UIColor(hex: "#059669")
                oneFiftyKWFastLabel.textColor = UIColor(hex: "#059669")
                leafView.isHidden = false
            }
        } else {
            availableChargersCountLabel.text = station.availability.status
            if station.availability.status.lowercased().contains("maintenance") {
                availableChargersCountLabel.textColor = UIColor(hex: "#991B1B")
                colorView.backgroundColor = UIColor(hex: "#991B1B").withAlphaComponent(0.2)
                insideColourView.backgroundColor = UIColor(hex: "#991B1B")
                kwView.backgroundColor = UIColor(hex: "#991B1B").withAlphaComponent(0.2)
                boltColourImgView.tintColor = UIColor(hex: "#991B1B")
                oneFiftyKWFastLabel.textColor = UIColor(hex: "#991B1B")
                pricePerKWHLabel.textColor = UIColor(hex: "#1F2937")
                leafView.isHidden = true
            } else {
                availableChargersCountLabel.textColor = UIColor(hex: "#1F2937")
                leafView.isHidden = true
            }
        }
    }
    
    private func configureReliabilityColor(score: Int) {
        switch score {
        case 90...100:
            reliableView.backgroundColor = UIColor(hex: "#059669").withAlphaComponent(0.1)
            reliableLabel.textColor = UIColor(hex: "#059669")
            shieldImgView.tintColor = UIColor(hex: "#059669")
            dotView.backgroundColor = UIColor(hex: "#059669")
        case 70..<90:
            reliableView.backgroundColor = UIColor(hex: "#FFFBEB")
            reliableLabel.textColor = UIColor(hex: "#92400E")
            shieldImgView.tintColor = UIColor(hex: "#92400E")
            dotView.backgroundColor = UIColor(hex: "#92400E")
        default:
            reliableView.backgroundColor = UIColor(hex: "#FEF2F2")
            reliableLabel.textColor = UIColor(hex: "#991B1B")
            shieldImgView.tintColor = UIColor(hex: "#991B1B")
            dotView.backgroundColor = UIColor(hex: "#991B1B")
        }
    }
    
    @IBAction func starButtonAction(_ sender: Any) {
    }
    
    @IBAction func viewDetailsButtonAction(_ sender: Any) {
    }
    
    @IBAction func navigateButtonAction(_ sender: Any) {
    }
}

extension StationsListTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == connectortypesCollectionView {
            return min(connectorTypes.count, 2)
        } else if collectionView == amenitiesCollectionView {
            return amenities.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == connectortypesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectorsCVC", for: indexPath) as! ConnectorsCVC
            let connectorType = connectorTypes[indexPath.row]
            cell.configure(with: connectorType)
            return cell
        } else if collectionView == amenitiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCVC", for: indexPath) as! AmenitiesCVC
            let amenity = amenities[indexPath.row]
            cell.configure(with: amenity)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == connectortypesCollectionView {
            let connectorType = connectorTypes[indexPath.row]
            let text = connectorType.rawValue
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 20
            return CGSize(width: width, height: collectionView.frame.height)
        } else if collectionView == amenitiesCollectionView {
            let width = collectionView.frame.width * 0.10
            return CGSize(width: width, height: collectionView.frame.height)
        }
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}


extension StationsListTVC {
    func setUpUI() {
        backView.applyShadow()
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        connectortypesCollectionView.register(UINib(nibName: "ConnectorsCVC", bundle: nil), forCellWithReuseIdentifier: "ConnectorsCVC")
        if let layout = connectortypesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        amenitiesCollectionView.register(UINib(nibName: "AmenitiesCVC", bundle: nil), forCellWithReuseIdentifier: "AmenitiesCVC")
        if let layouts = amenitiesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
    }
}

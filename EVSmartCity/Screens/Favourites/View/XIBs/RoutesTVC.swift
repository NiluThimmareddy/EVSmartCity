//
//  RoutesTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 03/06/26.
//

import UIKit

class RoutesTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var routeNameLabel: UILabel!
    @IBOutlet weak var currentAddressLabel: UILabel!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var morebutton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
    }
    
    @IBAction func distanceButtonAction(_ sender: Any) {
    }
    
//    func configure(with route: FavouriteRouteModel) {
//        routeNameLabel.text = route.title
//        currentAddressLabel.text = route.currentAddress
//        destinationAddressLabel.text = route.destinationAddress
//        stopsLabel.text = "\(route.stops.count) stops"
//        timeLabel.text = route.time
//        distanceButton.setTitle(route.distance, for: .normal)
//    }
    
    func configure(with route: FavouriteRouteModel) {
        
        routeNameLabel.text = route.title
        currentAddressLabel.text = route.currentAddress
        destinationAddressLabel.text = route.destinationAddress
        stopsLabel.text = route.stops
        timeLabel.text = route.time
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: UIColor(hex: "#379D67")
        ]
        
        let attributedTitle = NSAttributedString(
            string: route.distance,
            attributes: attributes
        )
        
        distanceButton.setAttributedTitle(attributedTitle, for: .normal)
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 10,
            weight: .medium,
            scale: .small
        )
        
        let chevronImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: config
        )
        
        distanceButton.setImage(chevronImage, for: .normal)
        distanceButton.tintColor = .darkGray
        
        distanceButton.semanticContentAttribute = .forceRightToLeft
        distanceButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
    }
    
}

//
//  LeftMenuTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 18/05/26.

import UIKit

class LeftMenuTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lineColourView: UIView!
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuDiscriptionLabel: UILabel!
    @IBOutlet weak var stationCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineColourView.isHidden = true
        stationCountLabel.isHidden = true
        backView.backgroundColor = .clear
        stationCountLabel.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lineColourView.isHidden = true
        stationCountLabel.isHidden = true
        backView.backgroundColor = .clear
    }
    
    func configure(model: SideMenuModel, isSelected: Bool = false, showStationCount: Bool = false, stationCount: String? = nil) {
        menuImgView.image = UIImage(systemName: model.image)
        menuTitleLabel.text = model.title
        menuDiscriptionLabel.text = model.description
        
        if showStationCount {
            stationCountLabel.isHidden = false
            stationCountLabel.text = stationCount
        } else {
            stationCountLabel.isHidden = true
        }
        
        if isSelected {
            backView.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            lineColourView.isHidden = false
        } else {
            backView.backgroundColor = .clear
            lineColourView.isHidden = true
        }
    }
}

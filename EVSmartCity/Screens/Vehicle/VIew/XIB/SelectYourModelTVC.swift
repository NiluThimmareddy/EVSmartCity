//
//  SelectYourModelTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 04/05/26.
//

import UIKit

class SelectYourModelTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var carModelImgView: UIImageView!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var connectorTypesLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    let greenColor = UIColor(hex: "#379D67")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
        
        resetUI()
    }
    
    func configure(isSelected: Bool) {
        if isSelected {
            applySelectedUI()
        } else {
            resetUI()
        }
    }
    
    func applySelectedUI() {
        backView.backgroundColor = greenColor.withAlphaComponent(0.1)
        backView.layer.borderWidth = 0.5
        backView.layer.borderColor = greenColor.cgColor
        
        modelNameLabel.textColor = greenColor
        
        checkMarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkMarkButton.tintColor = greenColor
    }
    
    func resetUI() {
        backView.backgroundColor = .clear
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.clear.cgColor
        modelNameLabel.textColor = .label
        checkMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkMarkButton.tintColor = UIColor.lightGray
    }

    @IBAction func checkMarkButtonAction(_ sender: Any) {
    }
}

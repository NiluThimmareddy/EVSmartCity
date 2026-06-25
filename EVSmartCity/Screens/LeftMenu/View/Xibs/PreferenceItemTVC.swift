//
//  PreferenceItemTVC.swift
//  EVSmartCity
//
//  Created by Hitman on 18/06/26.

import UIKit

class PreferenceItemTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var preferenceIconView: UIImageView!
    @IBOutlet weak var preferenceNameLabel: UILabel!
    @IBOutlet weak var preferenceTypeButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .default
        backView.backgroundColor = .clear
        lineView.isHidden = true
        
        preferenceTypeButton.isUserInteractionEnabled = false
        preferenceTypeButton.backgroundColor = .clear
        preferenceTypeButton.layer.cornerRadius = 0
        preferenceTypeButton.layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backView.backgroundColor = .clear
        lineView.isHidden = true
        
        preferenceIconView.tintColor = .darkGray
        preferenceTypeButton.backgroundColor = .clear
        preferenceTypeButton.layer.cornerRadius = 0
        preferenceTypeButton.contentEdgeInsets = .zero
        preferenceTypeButton.titleEdgeInsets = .zero
        preferenceTypeButton.imageEdgeInsets = .zero
        preferenceTypeButton.setImage(nil, for: .normal)
        preferenceTypeButton.setTitle(nil, for: .normal)
        preferenceTypeButton.setAttributedTitle(nil, for: .normal)
    }
    
    func configure(image: String, title: String, description: String, isSelected: Bool = false) {
        preferenceIconView.image = UIImage(systemName: image)
        preferenceIconView.tintColor = .darkGray
        preferenceNameLabel.text = title
        preferenceNameLabel.font = UIFont.systemFont(ofSize: 16)
        preferenceNameLabel.textColor = .black
        
        // Check if it's Language cell
        let isLanguage = (title == "Language")
        
        // Create attributed string with exact font size 10 medium
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .medium),
            .foregroundColor: UIColor.darkGray
        ]
        let attributedTitle = NSAttributedString(string: description, attributes: attributes)
        
        if isLanguage {
            // LANGUAGE: Show text + chevron right
            preferenceTypeButton.setAttributedTitle(attributedTitle, for: .normal)
            preferenceTypeButton.contentHorizontalAlignment = .right
            preferenceTypeButton.backgroundColor = .clear
            preferenceTypeButton.layer.cornerRadius = 0
            preferenceTypeButton.contentEdgeInsets = .zero
            preferenceTypeButton.titleEdgeInsets = .zero
            
            // Add chevron image
            let chevronImage = UIImage(systemName: "chevron.right")
            preferenceTypeButton.setImage(chevronImage, for: .normal)
            preferenceTypeButton.tintColor = .gray
            preferenceTypeButton.semanticContentAttribute = .forceRightToLeft
            preferenceTypeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            preferenceTypeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
            
        } else {
            // APPEARANCE: Show text with light grey background tag (NO chevron)
            preferenceTypeButton.setAttributedTitle(attributedTitle, for: .normal)
            preferenceTypeButton.contentHorizontalAlignment = .center
            preferenceTypeButton.backgroundColor = UIColor(hex: "#E5E5EA")
            preferenceTypeButton.layer.cornerRadius = 4
            preferenceTypeButton.layer.masksToBounds = true
            preferenceTypeButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            preferenceTypeButton.titleEdgeInsets = .zero
            preferenceTypeButton.imageEdgeInsets = .zero
            preferenceTypeButton.setImage(nil, for: .normal)
            preferenceTypeButton.tintColor = .clear
        }
        
        // Selection handling
        if isSelected {
            backView.backgroundColor = UIColor(hex: "#379D67").withAlphaComponent(0.1)
            lineView.isHidden = false
            lineView.backgroundColor = UIColor(hex: "#379D67")
            preferenceIconView.tintColor = UIColor(hex: "#379D67")
        } else {
            backView.backgroundColor = .clear
            lineView.isHidden = true
            preferenceIconView.tintColor = .darkGray
        }
    }
}

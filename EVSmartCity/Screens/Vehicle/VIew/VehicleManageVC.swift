//
//  VehicleManageVC.swift
//  EVSmartCity
//
//  Created by Hitman on 16/06/26.
//

import UIKit

class VehicleManageVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var insideScrollview: UIView!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var vehicleManageTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var activeStatusLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var electricSedanTitleLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var connectorTitleLabel: UILabel!
    @IBOutlet weak var connectorTypeLabel: UILabel!
    @IBOutlet weak var capacityTitleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var acChargeTitleLabel: UILabel!
    @IBOutlet weak var acChargeKWLabel: UILabel!
    @IBOutlet weak var dcFastChargetitleLabel: UILabel!
    @IBOutlet weak var dcChargeKWLabel: UILabel!
    @IBOutlet weak var linkedRifdCardLabel: UILabel!
    @IBOutlet weak var linkedRFIDCardCollectionView: UICollectionView!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var otherVehiclesLabel: UILabel!
    @IBOutlet weak var inactiveCarImgView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var inactiveStatuslabel: UILabel!
    @IBOutlet weak var vehicleInfoLabel: UILabel!
    @IBOutlet weak var setAsActiveButton: UIButton!
    @IBOutlet weak var rfidCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var rfidCards: [RFIDModel] = [
        RFIDModel(cardNumber: "RFID-5481"),
        RFIDModel(cardNumber: "RFID-5482"),
        RFIDModel(cardNumber: "RFID-5483")
    ]
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeStatusLabel.clipsToBounds = true
        inactiveStatuslabel.clipsToBounds = true
        linkedRFIDCardCollectionView.register(UINib(nibName: "AddRFIDCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddRFIDCollectionViewCell")
        linkedRFIDCardCollectionView.register(UINib(nibName: "RFIDCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RFIDCollectionViewCell")
        linkedRFIDCardCollectionView.isScrollEnabled = false
       
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero

        linkedRFIDCardCollectionView.collectionViewLayout = layout
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        linkedRFIDCardCollectionView.layoutIfNeeded()
        rfidCollectionViewHeightConstraint.constant = linkedRFIDCardCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
    }
    
    @IBAction func viewDetailsButtobnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CarDetailsVC") as! CarDetailsVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func removeButtonAction(_ sender: Any) {
        if let index = selectedIndex {
            rfidCards.remove(at: index)
            selectedIndex = nil
        } else {
            rfidCards.removeAll()
        }

        linkedRFIDCardCollectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    @IBAction func setAsActiveButtonAction(_ sender: Any) {
    }
    
}


extension VehicleManageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return rfidCards.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == rfidCards.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddRFIDCollectionViewCell",for: indexPath) as! AddRFIDCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RFIDCollectionViewCell",for: indexPath
        ) as! RFIDCollectionViewCell
        
        cell.rfidLabel.text = "[ \(rfidCards[indexPath.row].cardNumber) ]"
        if selectedIndex == indexPath.row {
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor(hex: "168552").cgColor
            cell.contentView.layer.cornerRadius = 21
        } else {
            cell.contentView.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == rfidCards.count {
            return CGSize(width: 42, height: 42)
        }
        let text = "[ \(rfidCards[indexPath.row].cardNumber) ]"
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let width = (text as NSString).size(withAttributes: [.font: font]).width
        return CGSize(width: width + 40, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == rfidCards.count {
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CarDetailsVC") as! CarDetailsVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            if selectedIndex == indexPath.row {
                selectedIndex = nil
            } else {
                selectedIndex = indexPath.row
            }

            collectionView.reloadData()
        }
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}

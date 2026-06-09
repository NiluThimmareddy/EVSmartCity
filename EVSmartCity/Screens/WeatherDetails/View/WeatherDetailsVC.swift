//
//  WeatherDetailsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 02/06/26.
//

import UIKit

class WeatherDetailsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var weatherDetailsTitleLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var heatingTempLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var currentLocationlabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var feelsLikeMoreTempLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var aboutTheWeatherLabel: UILabel!
    @IBOutlet weak var weatherDescriptionlabel: UILabel!
    @IBOutlet weak var todaysOverViewLabel: UILabel!
    @IBOutlet weak var todaysOverViewCollectionView: UICollectionView!
    
    var fullDayTemperatures: [HourlyTemperature] = [
        
    HourlyTemperature(time: "6 AM", temperature: 18, iconName: "cloud.sun.fill"),
    HourlyTemperature(time: "7 AM", temperature: 20, iconName: "sun.max.fill"),
    HourlyTemperature(time: "8 AM", temperature: 24, iconName: "sun.max.fill"),
    HourlyTemperature(time: "9 AM", temperature: 28, iconName: "sun.max.fill"),
    HourlyTemperature(time: "10 AM", temperature: 32, iconName: "sun.max.fill"),
    HourlyTemperature(time: "11 AM", temperature: 35, iconName: "sun.max.fill"),
    
    HourlyTemperature(time: "12 PM", temperature: 38, iconName: "sun.max.fill"),
    HourlyTemperature(time: "1 PM", temperature: 40, iconName: "sun.max.fill"),
    HourlyTemperature(time: "2 PM", temperature: 41, iconName: "sun.max.fill"),
    HourlyTemperature(time: "3 PM", temperature: 42, iconName: "sun.max.fill"),
    HourlyTemperature(time: "4 PM", temperature: 41, iconName: "sun.max.fill"),
    HourlyTemperature(time: "5 PM", temperature: 39, iconName: "sun.max.fill"),
    
    HourlyTemperature(time: "6 PM", temperature: 36, iconName: "cloud.sun.fill"),
    HourlyTemperature(time: "7 PM", temperature: 33, iconName: "cloud.fill"),
    HourlyTemperature(time: "8 PM", temperature: 30, iconName: "moon.stars.fill"),
    HourlyTemperature(time: "9 PM", temperature: 27, iconName: "moon.fill"),
    HourlyTemperature(time: "10 PM", temperature: 24, iconName: "moon.fill"),
    HourlyTemperature(time: "11 PM", temperature: 21, iconName: "moon.fill"),
    
    HourlyTemperature(time: "12 AM", temperature: 19, iconName: "moon.fill"),
    HourlyTemperature(time: "1 AM", temperature: 18, iconName: "moon.fill"),
    HourlyTemperature(time: "2 AM", temperature: 17, iconName: "moon.fill"),
    HourlyTemperature(time: "3 AM", temperature: 16, iconName: "moon.fill"),
    HourlyTemperature(time: "4 AM", temperature: 15, iconName: "moon.fill"),
    HourlyTemperature(time: "5 AM", temperature: 14, iconName: "cloud.moon.fill")
    
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.applyOrangeGradient()
        todaysOverViewCollectionView.register(UINib(nibName: "TodayOverviewCVC", bundle: nil), forCellWithReuseIdentifier: "TodayOverviewCVC")
        if let layouts = todaysOverViewCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.minimumLineSpacing = 10
            layouts.minimumInteritemSpacing = 10
            layouts.estimatedItemSize = .zero
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.scrollToCurrentTime()
        }
    }
    
    private func scrollToCurrentTime() {
        let currentHourString = getCurrentHourString()
        
        if let index = fullDayTemperatures.firstIndex(where: { $0.time == currentHourString }) {
            let indexPath = IndexPath(item: index, section: 0)
            todaysOverViewCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }

    private func getCurrentHourString() -> String {
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        
        let ampm = hour >= 12 ? "PM" : "AM"
        hour = hour % 12
        if hour == 0 {
            hour = 12
        }
        
        return "\(hour) \(ampm)"
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}

extension WeatherDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fullDayTemperatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayOverviewCVC", for: indexPath) as! TodayOverviewCVC
        let weatherDetails = fullDayTemperatures[indexPath.row]
        cell.configure(with: weatherDetails)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 - 10, height: collectionView.frame.height)
    }
}

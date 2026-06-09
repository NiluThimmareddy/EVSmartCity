//
//  TodayOverviewCVC.swift
//  EVSmartCity
//
//  Created by Hitman on 02/06/26.
//
/*
import UIKit

class TodayOverviewCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with: HourlyTemperature) {
        hourLabel.text = with.time
        weatherIconImageView.image = UIImage(systemName: with.iconName)
        temperatureLabel.text = "\(with.temperature)°"
    }

}
*/

import UIKit

class TodayOverviewCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDefaultStyle()
    }
    
    private func setupDefaultStyle() {
        backView.backgroundColor = UIColor.systemBackground
        
        hourLabel.textColor = UIColor(hex: "#4B5563")
        weatherIconImageView.tintColor = UIColor(hex: "#F59E0B")
        temperatureLabel.textColor = UIColor(hex: "#4B5563")
    }
    
    private func setupCurrentTimeStyle() {
        backView.backgroundColor = UIColor(hex: "#FFF7ED")
        hourLabel.textColor = UIColor(hex: "#EA580C")
        weatherIconImageView.tintColor = UIColor(hex: "#EA580C")
        temperatureLabel.textColor = UIColor(hex: "#EA580C")
    }
    
    func configure(with weatherData: HourlyTemperature) {
        if weatherData.time == "Now" {
            hourLabel.text = getCurrentHourIn12HourFormat()
        } else {
            hourLabel.text = weatherData.time
        }
        
        weatherIconImageView.image = UIImage(systemName: weatherData.iconName)
        temperatureLabel.text = "\(weatherData.temperature)°"
        
        let timeToCompare = (weatherData.time == "Now") ? getCurrentHourIn12HourFormat() : weatherData.time
        
        if isCurrentTimeSlot(timeString: timeToCompare) {
            setupCurrentTimeStyle()
        } else {
            setupDefaultStyle()
        }
    }
    
    private func isCurrentTimeSlot(timeString: String) -> Bool {
        let currentHour = getCurrentHourIn12HourFormat()
        return timeString == currentHour
    }
    
    private func getCurrentHourIn12HourFormat() -> String {
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
}

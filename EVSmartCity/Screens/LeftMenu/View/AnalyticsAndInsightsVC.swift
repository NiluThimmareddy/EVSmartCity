//
//  AnalyticsAndInsightsVC.swift
//  EVSmartCity
//
//  Created by Hitman on 22/06/26.
/*
import UIKit

class AnalyticsAndInsightsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var electricBoltChargeLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var energyintelligenceLabel: UILabel!
    @IBOutlet weak var yourChargingHabitsLabel: UILabel!
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var totalKwPercentage: UILabel!
    @IBOutlet weak var totalKwUpArrowImgView: UIImageView!
    @IBOutlet weak var totalKwTitleLabel: UILabel!
    @IBOutlet weak var totalKwValueLabel: UILabel!
    @IBOutlet weak var cardOneView: UIView!
    @IBOutlet weak var co2OffsetPercentLabel: UILabel!
    @IBOutlet weak var co2OffsetArrowImgView: UIImageView!
    @IBOutlet weak var co2OffsetTitleLabel: UILabel!
    @IBOutlet weak var co2OffsetKgLabel: UILabel!
    @IBOutlet weak var cardTwoView: UIView!
    @IBOutlet weak var spendSarPercentLabel: UILabel!
    @IBOutlet weak var spendSarArrowImgView: UIImageView!
    @IBOutlet weak var spendSarTitleLabel: UILabel!
    @IBOutlet weak var spendSARPriceLabel: UILabel!
    @IBOutlet weak var cardThreeView: UIView!
    @IBOutlet weak var sessionsTitleLabel: UILabel!
    @IBOutlet weak var stableValueLabel: UILabel!
    @IBOutlet weak var cardFourView: UIView!
    @IBOutlet weak var card1View: UIView!
    @IBOutlet weak var card2View: UIView!
    @IBOutlet weak var card3View: UIView!
    @IBOutlet weak var card4View: UIView!
    @IBOutlet weak var smartInsightsView: UIView!
    @IBOutlet weak var smartInsightLabel: UILabel!
    @IBOutlet weak var generatedByAIButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var youChargedThisWeekLabel: UILabel!
    @IBOutlet weak var spendingThisWeekLabel: UILabel!
    @IBOutlet weak var dateFilterButton: UIButton!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var sarSpentPerDayLabel: UILabel!
    @IBOutlet weak var sarSpentsDatesLabel: UILabel!
    @IBOutlet weak var sarPriceLabel: UILabel!
    @IBOutlet weak var dateFilterLabel: UILabel!
    @IBOutlet weak var analyticsGraphView: UIView!
    @IBOutlet weak var highestDayPriceLabel: UILabel!
    @IBOutlet weak var highestDayLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    @IBOutlet weak var dailyAvgLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var peakDayLabel: UILabel!
    @IBOutlet weak var greenImpactView: UIView!
    @IBOutlet weak var greenImpactLabel: UILabel!
    @IBOutlet weak var ecoChampionButton: UIButton!
    @IBOutlet weak var co2SavedKgsLabel: UILabel!
    @IBOutlet weak var co2SavedLabel: UILabel!
    @IBOutlet weak var percentageRenewableLabel: UILabel!
    @IBOutlet weak var renewableEnergyLabel: UILabel!
    @IBOutlet weak var equivalentTreesLabel: UILabel!
    @IBOutlet weak var equivalentLabel: UILabel!
    @IBOutlet weak var petrolAvoidedLeatersLabel: UILabel!
    @IBOutlet weak var petrolAvoidedLabel: UILabel!
    @IBOutlet weak var batteryIntelligenceView: UIView!
    @IBOutlet weak var batteryInteligenceLabel: UILabel!
    @IBOutlet weak var optimalHealthButton: UIButton!
    @IBOutlet weak var realTimeHealthLabel: UILabel!
    @IBOutlet weak var sohIndexValueLabel: UILabel!
    @IBOutlet weak var sohIndexLabel: UILabel!
    @IBOutlet weak var dcChargeFreqLabel: UILabel!
    @IBOutlet weak var dcChargeFreqPercentLabel: UILabel!
    @IBOutlet weak var dcChargeProgressView: UIProgressView!
    @IBOutlet weak var avgStartSocLabel: UILabel!
    @IBOutlet weak var avgStartSocPercentLabel: UILabel!
    @IBOutlet weak var avgStartSocProgressView: UIProgressView!
    @IBOutlet weak var azureMlInsightLabel: UILabel!
    @IBOutlet weak var wearIsLowerThanTypicalFleetsLabel: UILabel!
    @IBOutlet weak var communityBenchmarkingView: UIView!
    @IBOutlet weak var communityBencmarklabel: UILabel!
    @IBOutlet weak var costEfficiencyLabel: UILabel!
    @IBOutlet weak var costEfficiencyPercentageLabel: UILabel!
    @IBOutlet weak var costEfficiencyProgressView: UIProgressView!
    @IBOutlet weak var usageFrequencyLabel: UILabel!
    @IBOutlet weak var usageFrequencyAverageLabel: UILabel!
    @IBOutlet weak var usageFrequencyprogressView: UIProgressView!
    @IBOutlet weak var greenImpactScoreLabel: UILabel!
    @IBOutlet weak var greenImpactScorePercentLabel: UILabel!
    @IBOutlet weak var greenimpactScoreProgressView: UIProgressView!
    @IBOutlet weak var pdfReportButton: UIButton!
    @IBOutlet weak var shareImapctButton: UIButton!
    @IBOutlet weak var howUsefulView: UIView!
    @IBOutlet weak var howUsefulWereThislabel: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var moreTipsButton: UIButton!
    @IBOutlet weak var accuracyButton: UIButton!
    @IBOutlet weak var simplerChartsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [cardOneView, cardTwoView,cardThreeView,cardFourView].forEach { corners in
            corners.layer.cornerRadius = 18
            corners.layer.masksToBounds = true
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func calenderButtonAction(_ sender: Any) {
        let datePickerVC = UIViewController()
        datePickerVC.view.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = "Select Date"
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(titleLabel)
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = .systemGray5
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(separatorLine)
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .systemBackground
        datePicker.layer.cornerRadius = 12
        datePicker.clipsToBounds = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(datePicker)
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 12
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(buttonStackView)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: "#379D67"), for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        cancelButton.backgroundColor = .clear
        cancelButton.layer.cornerRadius = 12
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = UIColor(hex: "#379D67").cgColor
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        doneButton.backgroundColor = UIColor(hex: "#379D67")
        doneButton.layer.cornerRadius = 12
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(doneButton)
        
        objc_setAssociatedObject(datePickerVC, "datePicker", datePicker, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(datePickerVC, "doneButton", doneButton, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(datePickerVC, "cancelButton", cancelButton, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: datePickerVC.view.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            datePicker.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor, constant: 12),
            datePicker.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor, constant: -12),
            datePicker.heightAnchor.constraint(equalToConstant: 420),
            
            buttonStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            buttonStackView.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 48),
            buttonStackView.bottomAnchor.constraint(equalTo: datePickerVC.view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
        
        datePickerVC.modalPresentationStyle = .pageSheet
        if let sheet = datePickerVC.sheetPresentationController {
            let totalHeight: CGFloat = 28 + 8 + 1 + 8 + 420 + 16 + 48 + 12 + 20
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return min(totalHeight, context.maximumDetentValue * 0.9)
            }
            sheet.detents = [customDetent, .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.selectedDetentIdentifier = .medium
        }
        present(datePickerVC, animated: true)
    }
    
    @IBAction func speakerButtonAction(_ sender: Any) {
    }
   
    @IBAction func pdfReportButtonAction(_ sender: Any) {
    }
    
    @IBAction func shareImpactButtonAction(_ sender: Any) {
    }
    
    @IBAction func dateFilterButtonTapped(_ sender: Any) {
    }
    
}

extension AnalyticsAndInsightsVC {
    func setUpUI() {
        card1View.applyLightShadow()
        card2View.applyLightShadow()
        card3View.applyLightShadow()
        card4View.applyLightShadow()
        smartInsightsView.addDashedBorder()
        howUsefulView.addDashedBorder()
        setupDateFilterMenu()
    }
    
    @objc func doneButtonTapped() {
        if let presentedVC = presentedViewController,
           let datePicker = objc_getAssociatedObject(presentedVC, "datePicker") as? UIDatePicker {
            let selectedDate = datePicker.date
            updateDataForSelectedDate(selectedDate)
        }
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    func updateDataForSelectedDate(_ date: Date) {
        let buttonFormatter = DateFormatter()
        buttonFormatter.dateFormat = "MMMM yyyy"
        let buttonTitle = buttonFormatter.string(from: date).uppercased()
        calenderButton.setTitle(buttonTitle, for: .normal)
        
        let labelFormatter = DateFormatter()
        labelFormatter.dateFormat = "MMMM yyyy"
        dateFilterLabel.text = labelFormatter.string(from: date)
    }
    
    func setupDateFilterMenu() {
        let todayAction = UIAction(title: "Today") { [weak self] _ in
            self?.didSelectDateFilter("Today")
        }
        let yesterdayAction = UIAction(title: "Yesterday") { [weak self] _ in
            self?.didSelectDateFilter("Yesterday")
        }
        let tomorrowAction = UIAction(title: "Tomorrow") { [weak self] _ in
            self?.didSelectDateFilter("Tomorrow")
        }
        let thisWeekAction = UIAction(title: "This Week") { [weak self] _ in
            self?.didSelectDateFilter("This Week")
        }
        let thisMonthAction = UIAction(title: "This Month") { [weak self] _ in
            self?.didSelectDateFilter("This Month")
        }
        dateFilterButton.menu = UIMenu(children: [
            todayAction,
            yesterdayAction,
            tomorrowAction,
            thisWeekAction,
            thisMonthAction
        ])
        dateFilterButton.showsMenuAsPrimaryAction = true
    }
    
    func didSelectDateFilter(_ filter: String) {
        dateFilterButton.setTitle(filter, for: .normal)
        
        switch filter {
            
        case "Today":
            print("Today selected")
            // Update graph and labels for today
            
        case "Yesterday":
            print("Yesterday selected")
            // Update graph and labels for yesterday
            
        case "Tomorrow":
            print("Tomorrow selected")
            // Update graph and labels for tomorrow
            
        case "This Week":
            print("This Week selected")
            // Update graph and labels for this week
            
        case "This Month":
            print("This Month selected")
            // Update graph and labels for this month
            
        default:
            break
        }
    }
}
*/

import UIKit

class AnalyticsAndInsightsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var electricBoltChargeLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var energyintelligenceLabel: UILabel!
    @IBOutlet weak var yourChargingHabitsLabel: UILabel!
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var totalKwPercentage: UILabel!
    @IBOutlet weak var totalKwUpArrowImgView: UIImageView!
    @IBOutlet weak var totalKwTitleLabel: UILabel!
    @IBOutlet weak var totalKwValueLabel: UILabel!
    @IBOutlet weak var cardOneView: UIView!
    @IBOutlet weak var co2OffsetPercentLabel: UILabel!
    @IBOutlet weak var co2OffsetArrowImgView: UIImageView!
    @IBOutlet weak var co2OffsetTitleLabel: UILabel!
    @IBOutlet weak var co2OffsetKgLabel: UILabel!
    @IBOutlet weak var cardTwoView: UIView!
    @IBOutlet weak var spendSarPercentLabel: UILabel!
    @IBOutlet weak var spendSarArrowImgView: UIImageView!
    @IBOutlet weak var spendSarTitleLabel: UILabel!
    @IBOutlet weak var spendSARPriceLabel: UILabel!
    @IBOutlet weak var cardThreeView: UIView!
    @IBOutlet weak var sessionsTitleLabel: UILabel!
    @IBOutlet weak var stableValueLabel: UILabel!
    @IBOutlet weak var cardFourView: UIView!
    @IBOutlet weak var card1View: UIView!
    @IBOutlet weak var card2View: UIView!
    @IBOutlet weak var card3View: UIView!
    @IBOutlet weak var card4View: UIView!
    @IBOutlet weak var smartInsightsView: UIView!
    @IBOutlet weak var smartInsightLabel: UILabel!
    @IBOutlet weak var generatedByAIButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var youChargedThisWeekLabel: UILabel!
    @IBOutlet weak var spendingThisWeekLabel: UILabel!
    @IBOutlet weak var dateFilterButton: UIButton!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var sarSpentPerDayLabel: UILabel!
    @IBOutlet weak var sarSpentsDatesLabel: UILabel!
    @IBOutlet weak var sarPriceLabel: UILabel!
    @IBOutlet weak var dateFilterLabel: UILabel!
    @IBOutlet weak var analyticsGraphView: UIView!
    @IBOutlet weak var highestDayPriceLabel: UILabel!
    @IBOutlet weak var highestDayLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    @IBOutlet weak var dailyAvgLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var peakDayLabel: UILabel!
    @IBOutlet weak var greenImpactView: UIView!
    @IBOutlet weak var greenImpactLabel: UILabel!
    @IBOutlet weak var ecoChampionButton: UIButton!
    @IBOutlet weak var co2SavedKgsLabel: UILabel!
    @IBOutlet weak var co2SavedLabel: UILabel!
    @IBOutlet weak var percentageRenewableLabel: UILabel!
    @IBOutlet weak var renewableEnergyLabel: UILabel!
    @IBOutlet weak var equivalentTreesLabel: UILabel!
    @IBOutlet weak var equivalentLabel: UILabel!
    @IBOutlet weak var petrolAvoidedLeatersLabel: UILabel!
    @IBOutlet weak var petrolAvoidedLabel: UILabel!
    @IBOutlet weak var batteryIntelligenceView: UIView!
    @IBOutlet weak var batteryInteligenceLabel: UILabel!
    @IBOutlet weak var optimalHealthButton: UIButton!
    @IBOutlet weak var realTimeHealthLabel: UILabel!
    @IBOutlet weak var sohIndexValueLabel: UILabel!
    @IBOutlet weak var sohIndexLabel: UILabel!
    @IBOutlet weak var dcChargeFreqLabel: UILabel!
    @IBOutlet weak var dcChargeFreqPercentLabel: UILabel!
    @IBOutlet weak var dcChargeProgressView: UIProgressView!
    @IBOutlet weak var avgStartSocLabel: UILabel!
    @IBOutlet weak var avgStartSocPercentLabel: UILabel!
    @IBOutlet weak var avgStartSocProgressView: UIProgressView!
    @IBOutlet weak var azureMlInsightLabel: UILabel!
    @IBOutlet weak var wearIsLowerThanTypicalFleetsLabel: UILabel!
    @IBOutlet weak var communityBenchmarkingView: UIView!
    @IBOutlet weak var communityBencmarklabel: UILabel!
    @IBOutlet weak var costEfficiencyLabel: UILabel!
    @IBOutlet weak var costEfficiencyPercentageLabel: UILabel!
    @IBOutlet weak var costEfficiencyProgressView: UIProgressView!
    @IBOutlet weak var usageFrequencyLabel: UILabel!
    @IBOutlet weak var usageFrequencyAverageLabel: UILabel!
    @IBOutlet weak var usageFrequencyprogressView: UIProgressView!
    @IBOutlet weak var greenImpactScoreLabel: UILabel!
    @IBOutlet weak var greenImpactScorePercentLabel: UILabel!
    @IBOutlet weak var greenimpactScoreProgressView: UIProgressView!
    @IBOutlet weak var pdfReportButton: UIButton!
    @IBOutlet weak var shareImapctButton: UIButton!
    @IBOutlet weak var howUsefulView: UIView!
    @IBOutlet weak var howUsefulWereThislabel: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var moreTipsButton: UIButton!
    @IBOutlet weak var accuracyButton: UIButton!
    @IBOutlet weak var simplerChartsButton: UIButton!

    var datePickerVC: UIViewController?
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setCurrentMonthYear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [cardOneView, cardTwoView,cardThreeView,cardFourView].forEach { corners in
            corners.layer.cornerRadius = 18
            corners.layer.masksToBounds = true
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func calenderButtonAction(_ sender: Any) {

        datePickerVC = UIViewController()
        guard let datePickerVC = datePickerVC else { return }

        datePickerVC.view.backgroundColor = .systemBackground

        let titleLabel = UILabel()
        titleLabel.text = "Select Date"
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(titleLabel)

        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(datePicker)

        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 12
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        datePickerVC.view.addSubview(buttonStackView)

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = UIColor(hex: "#379D67")
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(doneButton)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: datePickerVC.view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),

            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor, constant: 12),
            datePicker.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor, constant: -12),

            buttonStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: datePickerVC.view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: datePickerVC.view.trailingAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])

        datePickerVC.modalPresentationStyle = .pageSheet
        if let sheet = datePickerVC.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("custom")) { context in
                return context.maximumDetentValue * 0.66
            }
            sheet.detents = [customDetent]
            sheet.selectedDetentIdentifier = .init("custom")
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(datePickerVC, animated: true)
    }
    
    @IBAction func speakerButtonAction(_ sender: Any) {
    }
   
    @IBAction func pdfReportButtonAction(_ sender: Any) {
    }
    
    @IBAction func shareImpactButtonAction(_ sender: Any) {
    }
    
    @IBAction func dateFilterButtonTapped(_ sender: Any) {
    }
    
}

extension AnalyticsAndInsightsVC {
    func setUpUI() {
        card1View.applyLightShadow()
        card2View.applyLightShadow()
        card3View.applyLightShadow()
        card4View.applyLightShadow()
        smartInsightsView.addDashedBorder()
        howUsefulView.addDashedBorder()
        setupDateFilterMenu()
    }
    
    @objc func doneButtonTapped() {

        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"

        let monthYear = formatter.string(from: datePicker.date).uppercased()

        if var config = calenderButton.configuration {
            config.title = monthYear
            calenderButton.configuration = config
        } else {
            calenderButton.setTitle(monthYear, for: .normal)
        }

        dateFilterLabel.text = monthYear

        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    func setCurrentMonthYear() {

        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"

        let currentMonthYear = formatter.string(from: Date()).uppercased()

        if var config = calenderButton.configuration {
            config.title = currentMonthYear
            calenderButton.configuration = config
        } else {
            calenderButton.setTitle(currentMonthYear, for: .normal)
        }
    }
    
    func updateDataForSelectedDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"

        let monthYear = formatter.string(from: date).uppercased()

        var config = calenderButton.configuration
        config?.title = monthYear
        calenderButton.configuration = config

        dateFilterLabel.text = monthYear
    }
    
    func setupDateFilterMenu() {
        let todayAction = UIAction(title: "Today") { [weak self] _ in
            self?.didSelectDateFilter("Today")
        }
        let yesterdayAction = UIAction(title: "Yesterday") { [weak self] _ in
            self?.didSelectDateFilter("Yesterday")
        }
        let tomorrowAction = UIAction(title: "Tomorrow") { [weak self] _ in
            self?.didSelectDateFilter("Tomorrow")
        }
        let thisWeekAction = UIAction(title: "This Week") { [weak self] _ in
            self?.didSelectDateFilter("This Week")
        }
        let thisMonthAction = UIAction(title: "This Month") { [weak self] _ in
            self?.didSelectDateFilter("This Month")
        }
        dateFilterButton.menu = UIMenu(children: [
            todayAction,
            yesterdayAction,
            tomorrowAction,
            thisWeekAction,
            thisMonthAction
        ])
        dateFilterButton.showsMenuAsPrimaryAction = true
    }
    
    func didSelectDateFilter(_ filter: String) {
        dateFilterButton.setTitle(filter, for: .normal)
        
        switch filter {
            
        case "Today":
            print("Today selected")
            // Update graph and labels for today
            
        case "Yesterday":
            print("Yesterday selected")
            // Update graph and labels for yesterday
            
        case "Tomorrow":
            print("Tomorrow selected")
            // Update graph and labels for tomorrow
            
        case "This Week":
            print("This Week selected")
            // Update graph and labels for this week
            
        case "This Month":
            print("This Month selected")
            // Update graph and labels for this month
            
        default:
            break
        }
    }
}

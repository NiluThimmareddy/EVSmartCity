//
//  SplashViewController.swift
//  EVSmartCity
//
//  Created by ToqSoft on 24/11/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var SkipButton: UIButton!
    @IBOutlet weak var PageController: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    let SplashScreenDataArray = [
        SplashScreenData(image: "car", title: "Title1", description: "Description1", continueButtonTitle: "NEXT"),
        SplashScreenData(image: "car.fill", title: "Title2", description: "Description2", continueButtonTitle: "NEXT"),
        SplashScreenData(image: "house.fill", title: "Title3", description: "Description3", continueButtonTitle: "CONTINUE")
    ]
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func pageControleAction(_ sender: UIPageControl) {
        currentPage = sender.currentPage
        updateContent()
    }
    
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        openHomePage()
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        if currentPage < SplashScreenDataArray.count - 1 {
            currentPage += 1
            updateContent()
        }else{
            openHomePage()
        }
    }
}

extension SplashViewController {
    func setUpUI(){
        PageController.numberOfPages = SplashScreenDataArray.count
        PageController.currentPage = currentPage
       updateContent()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
    }
    
    func updateContent(){
        let data = SplashScreenDataArray[currentPage]
        imageView.image = UIImage(systemName: data.image)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        PageController.currentPage = currentPage
        continueButton.setTitle(data.continueButtonTitle, for: .normal)
        if currentPage == SplashScreenDataArray.count - 1{
            SkipButton.isHidden = true
        }else{
            SkipButton.isHidden = false
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left{
            if currentPage < SplashScreenDataArray.count - 1 {
                currentPage += 1
                updateContent()
            }
        }else if gesture.direction == .right{
            if currentPage > 0 {
                currentPage -= 1
                updateContent()
            }
        }
    }
}

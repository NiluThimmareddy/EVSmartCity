//
//  initialScreenViewController.swift
//  EVSmartCity
//
//  Created by ToqSoft on 05/12/25.
//

import UIKit

class initialScreenViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.alpha = 0
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.alpha = 1
            self.imageView.scalesLargeContentImage = true
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.openSplashScreen()
            }
        }
    }
    
}

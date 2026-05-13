//
//  FaceIDVC.swift
//  EVSmartCity
//
//  Created by Hitman on 08/05/26.
//

import UIKit
import AVFoundation
import LocalAuthentication

class FaceIDVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var faceIdTitleLabel: UILabel!
    @IBOutlet weak var faceIdView: UIView!
    @IBOutlet weak var alignYourFaceWithIntheFrameLabel: UILabel!
    @IBOutlet weak var makeSureYourFaceLabel: UILabel!
    @IBOutlet weak var scanningButton: UIButton!
    @IBOutlet weak var useFingerPrintButton: UIButton!
    @IBOutlet weak var usePasscodeButton: UIButton!

    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCameraPreview()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.authenticateUser()
        }
    }

    func setupCameraPreview() {
        captureSession = AVCaptureSession()
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video,position: .front) else {
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            if captureSession!.canAddInput(input) {
                captureSession!.addInput(input)
            }
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer?.videoGravity = .resizeAspectFill
            previewLayer?.frame = faceIdView.bounds
            faceIdView.layer.cornerRadius = faceIdView.frame.height / 2
            faceIdView.clipsToBounds = true
            if let previewLayer = previewLayer {
                faceIdView.layer.addSublayer(previewLayer)
            }
            DispatchQueue.global(qos: .background).async {
                self.captureSession?.startRunning()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Face ID Authentication

    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error) {
            let reason = "Authenticate using Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.scanningButton.setTitle("Verified", for: .normal)
                        print("Face ID Success")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let storyboard = UIStoryboard(name: "Login", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        } 
                    } else {
                        print("Authentication Failed")
                    }
                }
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func useFingerPrintButtonAction(_ sender: Any) {
//        let storyboard = storyboard?.instantiateViewController(withIdentifier: "FingerprintVerificationVC") as! FingerprintVerificationVC
//        storyboard.modalPresentationStyle = .fullScreen
//        present(storyboard, animated: true)
    }
    
    @IBAction func usePasscodeButtonAction(_ sender: Any) {
//        let storyboard = storyboard?.instantiateViewController(withIdentifier: "EnterYourPasscodeVC") as! EnterYourPasscodeVC
//        storyboard.modalPresentationStyle = .fullScreen
//        present(storyboard, animated: true)
    }
}

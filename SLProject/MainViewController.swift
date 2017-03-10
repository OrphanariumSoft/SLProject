//
//  MainViewController.swift
//  SLProject
//
//  Created by orphan on 09.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class MainViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    var isReaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isReaded {
            if Defaults.shared.codeFromQRReader == Defaults.shared.testQRCorrectCode {
                print("good code")
                //TEST!!!
                loginApp(withLogin:"root", andPassword:"root")
                
            } else {
                print("bad code")
                Defaults.shared.showAllertErrorWith(message: "QR Code is not valid!", andViewController: self)
            }
        }
    }

    lazy var readerVC = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {_ in 
        var reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
    })
    
    @IBAction func scanAction(_ sender: AnyObject) {
        readerVC.delegate = self

        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            
            print(result?.value ?? "noResult")
            if let value = result?.value {
                Defaults.shared.codeFromQRReader = value
                self.isReaded = true
            }
        }

        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startQRReaderVC(_ sender: Any) {
    }

    
    
    func changeMainScreen() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let categoryViewController = mainStoryBoard.instantiateViewController(withIdentifier: "navController") //as! CategoriesVC//instantiateViewControllerWithIdentifier("categoryVC") as! ViewController
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        UIView.transition(with: (appDelegate?.window)!,
                          duration: 0.5,
                          options: UIViewAnimationOptions.transitionFlipFromRight,
                          animations: {
                            appDelegate?.window?.rootViewController = categoryViewController
        }, completion: nil)
    }
    
    ////TEST!!!
    func loginApp(withLogin:String, andPassword:String) {
        
        ApiServerManager.shared.postLoginRequest(withLogin: withLogin, andPassword: andPassword,callback: { (result, error, responseText) in
            //if(error != 1) {
            var loginML = LoginML()
            if !error {
                loginML = (result[0] as? LoginML)!
                print(loginML.apiKey!)
                UserDefaults.standard.set(loginML.apiKey!, forKey: "api_key")
                UserDefaults.standard.set(true, forKey: "is_logged")
                self.changeMainScreen()
            } else {
                
            }
            
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

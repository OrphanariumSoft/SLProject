//
//  Defaults.swift
//  SLProject
//
//  Created by orphan on 08.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class Defaults: NSObject {

    static let shared = Defaults()
    
    var codeFromQRReader = String()
    let testQRCorrectCode = "root"
    
    func getLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "is_logged")
    }
    func getApiKey() -> String {
        return UserDefaults.standard.string(forKey: "api_key")!
    }
    
    func logOutAndTransition() {
        UserDefaults.standard.set(false, forKey: "is_logged")
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let categoryViewController = mainStoryBoard.instantiateViewController(withIdentifier: "mainVC")
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        UIView.transition(with: (appDelegate?.window)!,
                          duration: 0.5,
                          options: UIViewAnimationOptions.transitionFlipFromRight,
                          animations: {
                            appDelegate?.window?.rootViewController = categoryViewController
        }, completion: nil)
    }
    
    func showAllertErrorWith(message:String, andViewController: UIViewController) {
        let allert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let allertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        allert.addAction(allertActionOk)
        
        andViewController.present(allert, animated: true, completion: nil)
    }
    
    func showAllertGoodWith(message: String, andViewController: UIViewController) {
        let allert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let allertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        allert.addAction(allertActionOk)
        
        andViewController.present(allert, animated: true, completion: nil)
    }
    
    
}

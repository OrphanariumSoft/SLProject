//
//  ViewController.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    let touchUp = UITapGestureRecognizer()
    
    var loginML = LoginML()
    var model = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButtonOutlet.layer.cornerRadius = loginButtonOutlet.layer.frame.height / 2
        loginButtonOutlet.backgroundColor = UIColor.init(red: 132/255, green: 96/255, blue: 250/255, alpha: 1)
        loginButtonOutlet.setTitleColor(UIColor.white, for: .normal)
        
        touchUp.addTarget(self, action: #selector(onTap(_:)))
        
        passwordTextField.delegate = self
        loginTextField.delegate = self

        
        view.addGestureRecognizer(touchUp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loginAction()
        return true
    }
    
//Actions
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        loginAction()
    }
    
    func loginAction() {
        var login = String()
        var password = String()
        if let loginText = loginTextField.text {
            login = loginText
        }
        if let passwordText = passwordTextField.text {
            password = passwordText
        }
        loginApp(withLogin: login, andPassword: password)
    }
    
//API
    func loginApp(withLogin:String, andPassword:String) {
        
        ApiServerManager.shared.postLoginRequest(withLogin: withLogin, andPassword: andPassword,callback: { (result, error, responseText) in
            //if(error != 1) {
            if !error {
                self.loginML = (result[0] as? LoginML)!
                print(self.loginML.apiKey!)
                UserDefaults.standard.set(self.loginML.apiKey!, forKey: "api_key")
                UserDefaults.standard.set(true, forKey: "is_logged")
                self.changeMainScreen()
            } else {
                Defaults.shared.showAllertErrorWith(message: "Invalid login or password", andViewController: self)
            }
            
        })
       
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
    
//    func postGetCategories(withApiKey:String) {
//        
//        let postData: [String:String] = [
//        "api_key":withApiKey]
//        
//        Alamofire.request(apiURL, method: .post, parameters: postData ).responseJSON(completionHandler: {
//            response in
//            print(response.result.value)
//        })
//        
//    }
    
    
}


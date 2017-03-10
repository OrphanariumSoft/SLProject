//
//  ApiServerManager.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ApiServerManager: NSObject {

    static let shared = ApiServerManager()
    
    
    
    let apiURL = "http://scanapp.s-host.net"
    var array = NSMutableArray()
    //login
    func postLoginRequest(withLogin:String, andPassword:String, callback:@escaping (_ result :NSMutableArray,_ error: Bool, _ responseText: String) -> Void) {
        let postData = ["login":withLogin,"password":andPassword]
        var arrayS = NSMutableArray()
        Alamofire.request("\(apiURL)/login", method: .post , parameters : postData).responseJSON(completionHandler: {
            response in
            print("postLogin -> error \(String(describing: response.error))")
            print("postLogin -> data \(String(describing: response.result.value))")
            if response.result.value != nil {
            
                let JSON = response.result.value as! NSDictionary
                arrayS.add(LoginML().initWith(response: JSON))
                let error = JSON.object(forKey: "error") as! Bool
                var responseText = String()
                if error {
                    responseText = String( describing: JSON.object(forKey: "message")!)
                }
                
                callback(arrayS,error,responseText )
            }
            
            
            
        })
        print(self.array)
    }
    
    //data
    func getCategoryPostRequest(withApiKey:String, completion:@escaping (_ result:NSMutableArray, _ error: Bool, _ responseText: String) -> Void){
        
        let postData:[String:String] = [
        "api_key":withApiKey]
        
        Alamofire.request("\(apiURL)/categories", method: .post, parameters: postData).responseJSON(completionHandler:{ response in
            
            print("getProducts -> data \(String(describing: response.result.value))")
            if response.result.value != nil {
                let JSON = response.result.value as! NSDictionary
                let error =  JSON.object(forKey: "error") as! Bool
                let array = NSMutableArray()
                if !error {
                    let responseData:NSDictionary = JSON.object(forKey: "response") as! NSDictionary
                    let resAr:NSArray = (responseData.object(forKey: "categories") as? NSArray)!
                    for data in resAr {
                        let responseData = data as! NSDictionary
                        array.add(CategoryML().initWith(response: responseData))
                    }
                }
                
                print("getProducts -> error \(String(describing: error))")
                var responseText = String()
                if error {
                   responseText = String( describing: JSON.object(forKey: "message")!)
                }
                completion(array,error,responseText)
            }
        })
        
    }
    
    func getSubCategoryPostRequest(withApiKey:String, andParentId:String, completion:@escaping (_ result:NSMutableArray, _ error: Bool, _ responseText: String) -> Void){
        
        let postData:[String:String] = [
            "api_key":withApiKey]
        
        Alamofire.request("\(apiURL)/categories/\(andParentId)", method: .post, parameters: postData).responseJSON(completionHandler:{ response in
            print("getProducts -> error \(String(describing: response.error))")
            print("getProducts -> data \(String(describing: response.result.value))")
            if response.result.value != nil {
                let JSON = response.result.value as! NSDictionary
                let error =  JSON.object(forKey: "error") as! Bool
                let array = NSMutableArray()
                if !error {
                    let responseData:NSDictionary = JSON.object(forKey: "response") as! NSDictionary
                    let resAr:NSArray = (responseData.object(forKey: "categories") as? NSArray)!
                    for data in resAr {
                        let responseData = data as! NSDictionary
                        array.add(SubCategoryML().initWith(response: responseData))
                    }
                }
                var responseText = String()
                if error {
                    responseText = String( describing: JSON.object(forKey: "message")!)
                }
                completion(array,error,responseText)
            }
        })
        
    }
    
    func getProductPostRequest(withApiKey:String, andParentId:String, completion:@escaping (_ result:NSMutableArray, _ error: Bool, _ responseText: String) -> Void){
        
        let postData:[String:String] = [
            "api_key":withApiKey]
                
        Alamofire.request("\(apiURL)/products/category/\(andParentId)", method: .post, parameters: postData).responseJSON(completionHandler:{ response in
            print("getProducts -> error \(String(describing: response.error))")
            print("getProducts -> data \(String(describing: response.result.value))")
            //
            
            let array = NSMutableArray()
            if(response.result.value != nil) {
                let JSON = response.result.value as! NSDictionary
                let error =  JSON.object(forKey: "error") as! Bool
                if !error {
                    let responseData:NSDictionary = JSON.object(forKey: "response") as! NSDictionary
                    let resAr:NSArray = (responseData.object(forKey: "products") as? NSArray)!
                    for data in resAr {
                        let responseData = data as! NSDictionary
                        array.add(ProductML().initWith(response: responseData))
                    }
                }
                var responseText = String()
                if error {
                    responseText = String( describing: JSON.object(forKey: "message")!)
                }
                completion(array,error,responseText)
            }
        })
        
    }
    
    
    
    
}

//
//  LoginML.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class LoginML: NSObject {

    var apiKey:String?
    
    func initWith(response:NSDictionary) -> Any {
        apiKey = response.object(forKey: "api_key") as? String
        UserDefaults.standard.set(apiKey, forKey: "api_key")
        return self
    }
    
}

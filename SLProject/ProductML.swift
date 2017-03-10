//
//  ProductML.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class ProductML: NSObject {
    
    var productName:String?
    var productPhotoURL:String?
    var productId:String?
    var productCountInStock:String?
    
    func initWith(response:NSDictionary) -> Any {
        
        productName = response.object(forKey: "prods_name") as? String
        productId = String(describing:response.object(forKey: "prods_id")!)
        productPhotoURL = response.object(forKey: "prods_image") as? String
       // productCountInStock = String(describing:response.object(forKey: "prods_count")!)
        
        return self
    }

}

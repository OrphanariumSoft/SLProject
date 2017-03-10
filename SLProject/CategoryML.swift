//
//  ProductML.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class CategoryML: NSObject {
    
    var categoryName:String?
    var categoryId:String?
    var categoryPhotoUrl:String?
    

    func initWith(response:NSDictionary) -> Any {
        categoryName = response.object(forKey: "cats_name") as? String
        
        categoryId = String(describing: response.object(forKey: "cats_id")!)
        categoryPhotoUrl = response.object(forKey: "cats_image") as? String
        return self
    }
    
}

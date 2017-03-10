//
//  SubCategoryML.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class SubCategoryML: NSObject {
    
    var subCategoryName:String?
    var subCategoryId:String?
    var subCategoryPhotoURL:String?
    var subCategoryParentId:String?
    
    func initWith(response:NSDictionary) -> Any {
        subCategoryName = response.object(forKey: "cats_name") as? String
        subCategoryId = String(describing: response.object(forKey: "cats_id")!)
        subCategoryParentId = String(describing:response.object(forKey: "cats_parent_id")!)
        subCategoryPhotoURL = response.object(forKey: "cats_image") as? String
        
        return self
    }

}

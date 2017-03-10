//
//  SubCategoryVC.swift
//  SLProject
//
//  Created by orphan on 08.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var subCategoryTableView: UITableView!
    
    var parentId = String()
    var navigationTitle = String()
    
    var modelArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(parentId)
        loadDataFromServerWith(apiKey: Defaults.shared.getApiKey(), andParendId: parentId)
        self.navigationItem.title = navigationTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //API
    func loadDataFromServerWith(apiKey: String, andParendId: String) {
        
        ApiServerManager.shared.getSubCategoryPostRequest(
            withApiKey: apiKey,
            andParentId: andParendId,
            completion: { (result,error,responseText) in
                if !error {
                    self.modelArray = result
                    self.subCategoryTableView.reloadData()
                } else {
                    if responseText == "Access Denied. Invalid Api key" {
                        Defaults.shared.logOutAndTransition()
                    }
                }
        })
        
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath)
        
        let model:SubCategoryML = self.modelArray[indexPath.row] as! SubCategoryML
        
        cell.textLabel?.text = model.subCategoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:SubCategoryML = self.modelArray[indexPath.row] as! SubCategoryML
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let productVC = storyBoard.instantiateViewController(withIdentifier: "productVC") as! ProductVC
        
        if model.subCategoryId != nil {
            productVC.parentId = model.subCategoryId!
        }
        if model.subCategoryName != nil {
            productVC.navigationTitle = model.subCategoryName!
        }
        
        self.navigationController?.pushViewController(productVC, animated: true)
        
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

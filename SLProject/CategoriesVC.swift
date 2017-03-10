//
//  CategoriesVC.swift
//  SLProject
//
//  Created by orphan on 07.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var CategoryTableView: UITableView!
    var modelArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 132/255, green: 96/255, blue: 250/255, alpha: 1)

        
        loadDataFromServerWith(apiKey: Defaults.shared.getApiKey())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //API
    func loadDataFromServerWith(apiKey:String) {
        
        ApiServerManager.shared.getCategoryPostRequest(withApiKey: apiKey, completion: { (result,error,responseText) in
            if !error {
                self.modelArray = result
                self.CategoryTableView.reloadData()
            } else {
            if responseText == "Access Denied. Invalid Api key" {
                Defaults.shared.logOutAndTransition()
            }
        }
        })
    
    }
    @IBAction func logOut(_ sender: Any) {
        Defaults.shared.logOutAndTransition()
    }

    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let model:CategoryML = modelArray[indexPath.row] as! CategoryML
        
        cell.textLabel?.text = model.categoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:CategoryML = modelArray[indexPath.row] as! CategoryML
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let subCategoryVC = storyBoard.instantiateViewController(withIdentifier: "subCategoryVC") as! SubCategoryVC
      //  print(model.categoryId!)
        if model.categoryId != nil {
            subCategoryVC.parentId = model.categoryId!
        }
        if model.categoryName != nil {
            subCategoryVC.navigationTitle = model.categoryName!
        }
        
        self.navigationController?.pushViewController(subCategoryVC, animated: true)
        
        
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

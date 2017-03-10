//
//  ProductVC.swift
//  SLProject
//
//  Created by orphan on 08.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class ProductVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ProductTableView: UITableView!
    
    var navigationTitle = String()
    var parentId = String()
    
    var modelArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(parentId)
        self.navigationItem.title = navigationTitle
        
        loadDataFromServerWith(apiKey: Defaults.shared.getApiKey(), andParentId: parentId)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //API
    
    func loadDataFromServerWith(apiKey: String, andParentId: String) {
        
        ApiServerManager.shared.getProductPostRequest(
            withApiKey: apiKey,
            andParentId: andParentId,
            completion: { (result,error,responseText) in
                if !error {
                    self.modelArray = result
                    self.ProductTableView.reloadData()
                } else {
                    if responseText == "Access Denied. Invalid Api key" {
                        Defaults.shared.logOutAndTransition()
                    }
                }
        })
        
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prodCell", for: indexPath) as! ProductTableViewCell
        let model:ProductML = self.modelArray[indexPath.row] as! ProductML
        
        cell.productVC = self
        
        cell.configureCellWith(model: model)
        
        return cell
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

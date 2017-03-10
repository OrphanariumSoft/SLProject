//
//  ProductTableViewCell.swift
//  SLProject
//
//  Created by orphan on 08.03.17.
//  Copyright © 2017 orphan. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var deincrementOutlet: UIButton!
    @IBOutlet weak var incrementOutlet: UIButton!
    @IBOutlet weak var sendRequestOutlet: UIButton!
    
    var productVC = ProductVC()
    
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith(model:ProductML) {
    
        configureLayersWith(buttons: deincrementOutlet, incrementOutlet, sendRequestOutlet)
        
        self.productNameLabel.text = model.productName
        self.productCount.text = String(describing:count)
        
    }
    
    func configureLayersWith(buttons:UIButton...) {
        for button in buttons {
            button.setTitleColor(UIColor.white, for: .normal)
            let layer = button.layer
            layer.cornerRadius = 15
            layer.backgroundColor = UIColor.init(red: 132/255, green: 96/255, blue: 250/255, alpha: 1).cgColor
        }
    }
    
    
    
    @IBAction func deincrementAction(_ sender: Any) {
        count -= 1
        self.productCount.text = String(count)
    }
    
    
    @IBAction func incrementAction(_ sender: Any) {
        count += 1
        self.productCount.text = String(count)
    }
    
    @IBAction func sendOrderReuestToTheServer(_ sender: Any) {
        
        //order request
        //TEST!!
        Defaults.shared.showAllertGoodWith(message: "Request success", andViewController: productVC)
    }

}

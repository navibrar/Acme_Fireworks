//
//  ProductListTableViewCell.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import Foundation
import UIKit

class CartListTableViewCell: UITableViewCell
{
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var qntityLabel: UILabel!
    @IBOutlet weak var increaseQuantityButton: UIButton!
    
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setValueForCell(productList: CartProduct)
    {
        let stringTitle = productList.title as String
        self.lblTitle.text = stringTitle
        self.lblCategory.text = productList.category as String
        self.qntityLabel.text = "\(productList.qty)"
        self.photo.image = UIImage(named: productList.images)
    }
}

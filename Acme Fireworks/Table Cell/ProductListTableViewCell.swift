//
//  ProductListTableViewCell.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import Foundation
import UIKit

class ProductListTableViewCell: UITableViewCell
{
    
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblTag: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setValueForCell(productList: Product)
    {
        let stringTitle = productList.title as String
        self.lblTitle.text = stringTitle
        self.lblCategory.text = productList.category as String
        self.lblTag.text = productList.tag as String
        self.photo.image = UIImage(named: productList.images)
    }
   
}

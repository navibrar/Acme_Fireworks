//
//  CategoryCollectionViewCell.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryTitleLabel: UILabel!
    
    func setValueForCell(category: Category)
    {
        categoryImage.image = UIImage(named: category.image)
        categoryTitleLabel.text = category.title + " >"
    }
}

//
//  CartProduct.swift
//  Acme Fireworks
//
//  Created by administrator on 26/12/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit

class CartProduct: NSObject ,NSCoding{
    var id : String
    var images : String
    var tag : String
    var title : String
    var userId : String
    var category: String
    var productDescription: String
    var qty: Int = 0
    
    init(id: String, images: String, tag: String, title: String, userId: String, category: String, productDescription: String, qty: Int) {
        // Dictionary object
        self.id = id
        self.images = images
        self.tag = tag
        self.title = title
        self.userId = userId
        self.category = category
        self.productDescription = productDescription
        self.qty = qty
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id");
        aCoder.encode(self.images, forKey: "images");
        aCoder.encode(self.tag, forKey: "tag");
        aCoder.encode(self.title, forKey: "title");
        aCoder.encode(self.userId, forKey: "userId");
        aCoder.encode(self.category, forKey: "category");
        aCoder.encode(self.productDescription, forKey: "productDescription");
        aCoder.encode(self.qty, forKey: "qty");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = (aDecoder.decodeObject(forKey: "id") as? String)!;
        self.images = (aDecoder.decodeObject(forKey: "images") as? String)!;
        self.tag = (aDecoder.decodeObject(forKey: "tag") as? String)!;
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)!;
        self.userId = (aDecoder.decodeObject(forKey: "userId") as? String)!;
        self.category = (aDecoder.decodeObject(forKey: "category") as? String)!;
        self.productDescription = (aDecoder.decodeObject(forKey: "productDescription") as? String)!;
        self.qty = aDecoder.decodeInteger(forKey: "qty")
        
    }
    

}

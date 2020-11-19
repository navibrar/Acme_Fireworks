//
//  Product.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import Foundation

struct Product {
    let id : String
    let images : String
    let tag : String
    let title : String
    let userId : String
    let category: String
    let productDescription: String
    var qty: Int

//    func saveMyListData(notification:Notification){
//        DBManager.shared.createDatabase()
//        var myList = [MyList]()
//        if let list =  notification.userInfo!["items"]
//        {
//            for value in (list as! NSArray) {
//                let valueDict = (value  as! NSDictionary)
//                var images = ""
//                let ean = valueDict["ean"] ?? "n/a"
//                let id = valueDict["id"] ?? "n/a"
//                if let imageList =  valueDict["images"]
//                {
//                    for listValue in (imageList as! NSArray) {
//                        let valueStr = (listValue  as! String)
//                        let imageType = self.isImageType(str: valueStr)
//                        if imageType
//                        {
//                            images = valueStr
//                            break
//                        }
//                    }
//                }
//                let model = valueDict["model"] ?? "n/a"
//                let title = valueDict["title"] ?? "n/a"
//                let userId = valueDict["userId"] ?? "n/a"
////                let createdDate = self.changeTimestampToDateString(timestamp: Double(valueDict["created_at"] as! String)!)
//                let createdDate = valueDict["created_at"] ?? "n/a"
//                let listValue = MyList(ean: ean as! String, id: id as! String, images: images , model: model as! String, title: title as! String, userId: userId as! String, createdAt: createdDate as! String)
//
//                myList.append(listValue)
//            }
//
//                DBManager.shared.insertMovieData(scannedData: myList)
//
//        }
//    }
    

}

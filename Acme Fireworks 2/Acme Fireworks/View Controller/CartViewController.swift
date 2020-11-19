//
//  CartViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/21/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class CartViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    let productCountLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 20, height: 20))
    var productList = [CartProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Cart"
        rightBarItem.image = UIImage(named:"cartBag")?.withRenderingMode(.alwaysOriginal)
        navigationSetCart()
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: "products") as? Data {
            productList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [CartProduct]
        }
        listTableView.reloadData()
        self.listTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setCartCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func increaseQntyButtonAction(_ sender: Any) {
        let myIndexPath = NSIndexPath(row: (sender as AnyObject).tag, section: 0)
        let cell = listTableView.cellForRow(at: myIndexPath as IndexPath) as? CartListTableViewCell
        //Now change the text
        let productValue = productList[myIndexPath.row] as CartProduct
        if (productValue.qty < 10 )
        {
            let qty = productValue.qty + 1
            cell?.qntityLabel.text = "\(qty)"
            productList[myIndexPath.row].qty = qty
        }
        self.updateCart()
    }
    @IBAction func deccreaseQntyButtonAction(_ sender: Any) {
        let myIndexPath = NSIndexPath(row: (sender as AnyObject).tag, section: 0)
        let cell = listTableView.cellForRow(at: myIndexPath as IndexPath) as? CartListTableViewCell
        //Now change the text
        let productValue = productList[myIndexPath.row] as CartProduct
        if (productValue.qty > 1 )
        {
            let qty = productValue.qty - 1
            cell?.qntityLabel.text = "\(qty)"
            productList[myIndexPath.row].qty = qty
        }
      self.updateCart()
    }
    
    
    // MARK :- tableview delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //make sure you use the relevant array sizes
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : CartListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CartListTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)![0] as! CartListTableViewCell;
        }
        cell.increaseQuantityButton.tag = indexPath.row
        cell.decreaseQuantityButton.tag = indexPath.row
        cell.setValueForCell(productList: productList[indexPath.row])
        return cell as CartListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.productList.remove(at: index.row)
            self.updateCart()
            self.listTableView.reloadData()
            print("delete button tapped")
        }
        delete.backgroundColor = .red
        return [delete]
    }
    
    // MARK :- Tabbar Button Actions

    @IBAction func shareCartButtonAction(_ sender: Any) {
        shareImage()
    }
    
    func shareTextButton() {
        
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    // share image
    func shareImage() {
        
        // image to share
        let image = UIImage(named: "welcome")
        
        // set up activity view controller
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.addToReadingList , UIActivityType.copyToPasteboard , UIActivityType.openInIBooks , UIActivityType.mail ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func requestToQuoteButtonAction(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        sendMail()
    }
    
    // MARK :- Update Cart
    
    func updateCart()  {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "products")
        if self.productList.count > 0
        {
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: self.productList), forKey: "products")
        }
        self.setCartCount()
    }
    // MARK :- Mail Composer

    func sendMail()  {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["navpreet.kaur@nvish.com"])
        composeVC.setSubject("Request to quote")
        composeVC.setMessageBody("Can you please send me the deails.", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 // MARK: - Navigation Items
    func navigationSetCart() {
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        //        let label = UILabel(frame: CGRect(x: 20, y: 2, width: 20, height: 20))
        productCountLabel.text = "0"
        self.setCartCount()
        productCountLabel.textAlignment = NSTextAlignment.center
        productCountLabel.textColor = UIColor.white
        productCountLabel.font = productCountLabel.font.withSize(11)
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageview.image = UIImage(named: "bag")
        containView.addSubview(imageview)
        containView.addSubview(productCountLabel)
        let cartTap = UITapGestureRecognizer(target: self, action: #selector(self.cartButtonTappedClicked))
        cartTap.numberOfTapsRequired = 1
        containView.addGestureRecognizer(cartTap)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containView)
    }
    @objc func cartButtonTappedClicked() {
//        self.performSegue(withIdentifier: "cart", sender: self)
    }
    
    func setCartCount() {
        productCountLabel.text = "0"
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: "products") as? Data {
            let productList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [CartProduct]
            productCountLabel.text = "\(productList.count)"
        }
    }
}

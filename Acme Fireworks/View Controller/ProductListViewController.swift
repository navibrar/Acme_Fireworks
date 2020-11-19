//
//  ProductListViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView!

    let productCountLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 20, height: 20))

    var productList = [Product]()
    var category:Category!
    var searchActive : Bool = false
    var filtered = [Product]()

    override func viewDidLoad() {
        if let categoryValue = category
        {
            self.title = categoryValue.title
        }
        else
        {
            self.title = "Offer"
        }
        rightBarItem.image = UIImage(named:"cartBag")?.withRenderingMode(.alwaysOriginal)
        self.searchListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.productList = category.product
        searchBar.delegate = self
        self.hideKeyboard()

        navigationSetCart()
        listTableView.reloadData()
        self.listTableView.tableFooterView = UIView()
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setCartCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Button Actions

    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.filtered.removeAll()
        self.searchActive = false
        self.searchListTableView.reloadData()
        self.listTableView.reloadData()
    }
        
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
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
        self.performSegue(withIdentifier: "cart", sender: self)
    }
    
    func setCartCount() {
        productCountLabel.text = "0"
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: "products") as? Data {
            let productList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [CartProduct]
            productCountLabel.text = "\(productList.count)"
        }
    }
    // MARK: - tableview delegate

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == searchListTableView
        {
            if filtered.count > 0 {
                self.searchListTableView.isHidden = false
            }
            var height : CGFloat = 45
            if filtered.count > 5
            {
                height = height * 5
            }
            else{
                height = CGFloat(filtered.count) * height
            }
            var tableFrame = self.searchListTableView.frame
            tableFrame.size.height = height;
            self.searchListTableView.frame = tableFrame
            
            return filtered.count
        }
        if(searchActive) {
            return filtered.count
        }
        //make sure you use the relevant array sizes
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == searchListTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
            let categoryValue = filtered[indexPath.row] as Product
            cell.textLabel?.text = categoryValue.title
            return cell
        }
        
        var cell : ProductListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductListTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)![0] as! ProductListTableViewCell;
        }
        var productValue : Product!

        if(searchActive) {
            productValue = filtered[indexPath.row] as Product
        }
        else
        {
            productValue = productList[indexPath.row] as Product
        }

        cell.setValueForCell(productList: productValue)
        return cell as ProductListTableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchListTableView {
            self.searchBar.resignFirstResponder()
            let categoryValue = filtered[indexPath.row] as Product
            searchBar.text = categoryValue.title
            self.searchBar(self.searchBar, textDidChange: searchBar.text!)
            self.searchListTableView.isHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchListTableView.isHidden = true
        guard segue.identifier == "ProductDetail",
            let cell = sender as? UITableViewCell,
            let indexPath = listTableView.indexPath(for: cell) else {
                return
        }
        let index = indexPath.row
        let selectedValue : Product!
        
        if(searchActive) {
            selectedValue = filtered[index]
        }
        else{
            selectedValue = productList[index]
        }
        
        if let vc = segue.destination as? ProductDetailViewController {
            vc.productDetail = selectedValue
            vc.category = self.category
        }
    }
    
    // MARK: - Search bar delegates
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
        //        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
        self.listTableView.reloadData()
        self.searchListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true;

        filtered = productList.filter({( product : Product) -> Bool in
            return product.title.lowercased().contains(searchText.lowercased())
        })
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.listTableView.reloadData()
        self.searchListTableView.reloadData()
    }
}

extension ProductListViewController :UIGestureRecognizerDelegate
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ProductListViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let tableTap = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        self.listTableView.backgroundView = UIView()
        self.listTableView.backgroundView?.addGestureRecognizer(tableTap)

    }
    @objc func tableTapped(tap:UITapGestureRecognizer) {
        let location = tap.location(in: self.listTableView)
        let path = self.listTableView.indexPathForRow(at: location)
        if path != nil {
//            self.tableView(self.listTableView, didSelectRowAt: indexPathForRow)
        } else {
            self.dismissKeyboard()
            // handle tap on empty space below existing rows however you want
        }
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    // UIGestureRecognizerDelegate method
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.searchListTableView) == true {
            return false
        }
        if touch.view?.isDescendant(of: self.listTableView) == true {
            return false
        }
        
        return true
    }
}



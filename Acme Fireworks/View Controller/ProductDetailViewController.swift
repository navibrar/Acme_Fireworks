//
//  ProductDetailViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {
    

    var productDetail:Product!
    var category:Category!

    var imagelist = ["ProductDetailImage"]
    var currentnImageIndex: NSInteger = 0
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl(frame:CGRect(x: 50, y: 300, width: 200, height: 50))
    let productCountLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 20, height: 20))

    
    @IBOutlet weak var imagePreviewBackView: UIView!
    @IBOutlet weak var imagePreviewView: UIImageView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var descriptionHighlightedView: UIView!
    @IBOutlet weak var reviewHighlightedView: UIView!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarItem.image = UIImage(named:"cartBag")?.withRenderingMode(.alwaysOriginal)
        navigationSetCart()
        imagelist = imagelist + category.detailImage
        self.title = productDetail.id
        self.productNameLabel.text = productDetail.title
        self.productCategoryLabel.text = productDetail.category
        DescriptionTextView.text = productDetail.productDescription
        configureScrollViewForImages()
        configurePageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideImagePreviewView()
        self.setCartCount()
    }

    func hideImagePreviewView() {
        self.imagePreviewBackView.isHidden = true
        self.imagePreviewView.image = nil
    }
    
    func showAnimate()
    {
        self.imagePreviewBackView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.imagePreviewBackView.alpha = 0.0;
        UIView.animate(withDuration: 0.50, animations: {
            self.imagePreviewBackView.alpha = 1.0
            self.imagePreviewBackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        });
    }
    
    func hideImagePreviewViewWithAnimation()
    {
        UIView.animate(withDuration: 0.50, animations: {
            self.imagePreviewBackView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.imagePreviewBackView.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.imagePreviewBackView.isHidden = true
                self.imagePreviewView.image = nil
            }
        });
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
//    func navigationSetCart() {
//        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        let label = UILabel(frame: CGRect(x: 20, y: 2, width: 20, height: 20))
//        label.text = "0"
//        let userDefaults = UserDefaults.standard
//        if let decoded = userDefaults.object(forKey: "products") as? Data {
//            let productList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [CartProduct]
//            label.text = "\(productList.count)"
//        }
//        label.textAlignment = NSTextAlignment.center
//        label.textColor = UIColor.white
//        label.font = label.font.withSize(11)
//        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageview.image = UIImage(named: "bag")
//        containView.addSubview(imageview)
//        containView.addSubview(label)
//        
////        let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "test.png"), style: .plain, target: self, action: nil)
//
//        let searchBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchButtonTapped))
//        searchBarButton.image = UIImage(named:"serach")?.withRenderingMode(.alwaysOriginal)
//
//        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: containView),searchBarButton]
//    }

    // MARK : PAGINATION AND SCROLL TO SCROLL IMAGES
    func configureScrollViewForImages() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.imagesView.frame.width, height: self.imagesView.frame.height)
        self.pageControl.frame = CGRect(x: 0, y: self.imagesView.frame.height - 70, width: self.imagesView.frame.width, height: 50)
        
        scrollView.delegate = self
        self.imagesView.addSubview(scrollView)
        for index in 0..<imagelist.count {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            frame.size.height = self.scrollView.frame.height - 30
            let myImage:UIImage = UIImage(named: imagelist[index])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.frame = frame
            self.scrollView.addSubview(myImageView)
            
            let playIconHeightWidth = CGFloat(50)
            let playImageframe: CGRect = CGRect(x: myImageView.frame.size.width/2 - playIconHeightWidth/2 , y: myImageView.frame.size.height/2 - playIconHeightWidth/2, width: playIconHeightWidth, height: playIconHeightWidth)
            let playImage:UIImage = UIImage(named: "playIcon")!
            let playImageView:UIImageView = UIImageView()
            playImageView.image = playImage
            playImageView.frame = playImageframe
            self.scrollView.addSubview(playImageView)
        }
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(self.tapPage(sender:)))
        scrollViewTap.numberOfTapsRequired = 1
        self.scrollView.addGestureRecognizer(scrollViewTap)

    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = imagelist.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.imagesView.addSubview(pageControl)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    @objc func tapPage(sender: UIScrollView) {
        print("scrollViewTapped")
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        let imageSelected = UIImage(named: imagelist[Int(pageNumber)])!
        if (pageNumber == 0)
        {
            playVideo()
        }
        else
        {
            self.imagePreviewView.image = imageSelected
            self.imagePreviewBackView.isHidden = false
            showAnimate()
        }
    }

    
    func playVideo()
    {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true)
        {
            playerViewController.player!.play()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Button Action
    @IBAction func descriptionButtonAction(_ sender: Any) {
    }
    
    @IBAction func reviewButtonAction(_ sender: Any) {
    }
    
    
    // MARK: - Navigation Button Action
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        performSegue(withIdentifier: "cartDetail", sender: nil)

    }
    
    // MARK: - Bottom Bar Button Action
    @IBAction func shareButtonAction(_ sender: Any){
        shareImage()
    }
    
    @IBAction func addToCartButtonAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        var productsInCart = [CartProduct]()
        if let decoded = userDefaults.object(forKey: "products") as? Data {
            productsInCart = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [CartProduct]
        }
        
        var productAddedArray = [CartProduct(id: self.productDetail.id,images: self.productDetail.images, tag: self.productDetail.tag,  title: self.productDetail.title, userId: self.productDetail.userId, category: self.productDetail.category, productDescription: self.productDetail.productDescription, qty: self.productDetail.qty + 1 )]
        
//        productsInCart = productsInCart.filter { $0.id != self.productDetail.id}

        for index in 0..<productsInCart.count {
            let cartProduct = productsInCart[index] as CartProduct
            if cartProduct.id == self.productDetail.id
            {
                productsInCart.remove(at: index)
                cartProduct.qty = productAddedArray[0].qty + cartProduct.qty
                productsInCart.insert(cartProduct, at: index)
                productAddedArray.removeAll()
            }
        }
        
//        productsInCart = productsInCart.filter { $0.id != self.productDetail.id}
       
        if productsInCart.count > 0 {
            let finalArray = productsInCart + productAddedArray
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: finalArray), forKey: "products")
        }
        else{
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: productAddedArray), forKey: "products")
        }
        userDefaults.synchronize()
        self.setCartCount()
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Cart", message: "Item successfully added to your cart", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "View Cart", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.performSegue(withIdentifier: "cart", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func addToWishlistButtonAction(_ sender: Any) {
    }
    
    @IBAction func dismissImagePreviewView(_ sender: Any) {
        hideImagePreviewViewWithAnimation()
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var searchListTableView: UITableView!
    
    var categoryList = [Category]()
    let categoryListimagelist = ["category1","category2","category3","category4"]
    let categoryListTitlelist = ["Firecracker","Cakes","Fountain & Cones","Sparklers"]
    let searchList = ["Firecracker","Cakes","Fountain & Cones","Sparklers"]
    var searchActive : Bool = false
    var filtered = [Category]()
    let productCountLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 20, height: 20))

    var imagelist = ["OfferWithText","OfferWithText"]
    var currentnImageIndex: NSInteger = 0
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl(frame:CGRect(x: 50, y: 300, width: 200, height: 50))

    
    let cakeImageList = ["cake1","cake2","cake3","cake4","cake5","cake6","cake7","cake8","cake9","cake10","cake11","cake12","cake13","cake14","cake15","cake16","cake17"]
     let cakeTitlelist = ["30S Master Blaster AC2162","K7158S","peida","RL1001 #100Mix", "RL2003 Glory 25S","RL2011 Sky light 25S","RL2014 Buzzing Bee 14S","RL2016 Air Attack 36s","RL2018 One bad bady 10S","RL5061 Crazy Clown 36S","RL5088 Rock Star 8S","RL5090 Making Thunder 9S","RL5093 Volverine Glove 145S","RL5095 Screw Attack 63S","RL5097 Stunts Amazing 33s","RL5104 Crazy rollercoaster 9S","RL5108 The Island 38S"]
    let cakeIdlist = ["30S Master Blaster AC2162","K7158S","peida","RL1001 #100Mix", "RL2003 Glory 25S","RL2011 Sky light 25S","RL2014 Buzzing Bee 14S","RL2016 Air Attack 36s","RL2018 One bad bady 10S","RL5061 Crazy Clown 36S","RL5088 Rock Star 8S","RL5090 Making Thunder 9S","RL5093 Volverine Glove 145S","RL5095 Screw Attack 63S","RL5097 Stunts Amazing 33s","RL5104 Crazy rollercoaster 9S","RL5108 The Island 38S"]
    let cakeCategorylist = ["Cakes, Common Cakes","200g & 500g Cakes, Cakes","200g & 500g Cakes, Cakes","200g & 500g Cakes, Cakes","200g & 500g Cakes, Cakes","R220g & 500g cakes","R220g & 500g cakes","R220g & 500g cakes","R220g & 500g cakes","R220g & 500g cakes","3' Cakes, Cakes","3' Cakes, Cakes","Cakes, Common Cakes","Cakes, Common Cakes","Cakes, Common Cakes","Cakes, Common Cakes","Cakes, Common Cakes"]
    let cakeTaglist = ["Cakes","Cakes","Cakes","200g","200g","200g","200g","200g","200g","200g","500g","500g","New","New","New","New","New"]
    let cakeDetailPageImagelist = ["cakeDetail1","cakeDetail2","cakeDetail3"]
    let cakeDeclist = ["30S Master Blaster AC2162 Packing:6/1","Cactus Rain Packing:48/6","peida","RL1001 #100Mix","RL2003 Glory 25S","RL2011 Sky light 25S","RL2014 Buzzing Bee 14S","RL2016 Air Attack 36s","RL2018 One bad bady 10S","RL5061 Crazy Clown 36S","RL5088 Rock Star 8S","RL5090 Making Thunder 9S","RL5093 Volverine Glove 145S","RL5095 Screw Attack 63S","RL5097 Stunts Amazing 33s","RL5104 Crazy rollercoaster 9S","RL5108 The Island 38S"]
    
    
    
    let firecrackersImageList = ["firecracker1","firecracker2","firecracker3","firecracker4","firecracker5","firecracker6","firecracker7","firecracker8","firecracker9","firecracker10","firecracker11","firecracker12","firecracker13","firecracker14","firecracker15","firecracker16","firecracker17","firecracker18"]
    let firecrackersTitlelist = ["3# Match Cracker K0203 100","12S Tumbero AF3047","Big Hand Thunder AF3008","Bird Egg AF3003","Bottle Bang AF3011","Cracker Bomb Φ1.2cmX1.0cm W667A","Cracker Bomb Φ1.4cmX1.4cm AP1004","Crackling Flash Φ1.2cm_2cm 765","Dinosaur Eggs Φ1cmX1cm W667","Fivefold Color Cracker Ball AF1008","Fivefold Color Cracker Ball W669","Football Crackers AF3010","Hand Thunder AF3007","Happy Flowers AF1004 Happy Flower","Hot Flashes AF1007","lluminador AF1009","Pili Cracker Φ1.2cmX1.2cm 1024","Silver Glittering Flowers AF1001"]
    let firecrackersIdlist = ["3# Match Cracker K0203 100","12S Tumbero AF3047","Big Hand Thunder AF3008","Bird Egg AF3003","Bottle Bang AF3011","Cracker Bomb Φ1.2cmX1.0cm W667A","Cracker Bomb Φ1.4cmX1.4cm AP1004","Crackling Flash Φ1.2cm_2cm 765","Dinosaur Eggs Φ1cmX1cm W667","Fivefold Color Cracker Ball AF1008","Fivefold Color Cracker Ball W669","Football Crackers AF3010","Hand Thunder AF3007","Happy Flowers AF1004 Happy Flower","Hot Flashes AF1007","lluminador AF1009","Pili Cracker Φ1.2cmX1.2cm 1024","Silver Glittering Flowers AF1001"]
    let firecrackersCategorylist = ["Firecrackers","Firecrackers","Firecrackers","Firecrackers","Firecrackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers","Firecrackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers","Firecrackers, Flashings & Pili Crackers"]
    let firecrackersTaglist = ["Firecrackers","Firecrackers","Firecrackers","Firecrackers","Firecrackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers","Firecrackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers","Firecrackers, Flashings, Pili Crackers"]
    let firecrackersDetailPageImagelist = ["firecrackersDetail1","firecrackersDetail2","firecrackersDetail3"]
    let firecrackersDeclist = ["K02033# Match Cracker Packing:50/100","12S Tumbero AF3047 Packing:24/4","Big Hand Thunder AF3008 Packing:72/2","Bird Egg AF3003 Packing:25/10/8","Bottle Bang AF3011 Packing:120/12","Cracker Bomb Φ 1.2cmX1.0cm W667A Packing:48/24/6","Cracker Bomb Φ 1.4cmX1.4cm AP1004 Packing:60/40","Crackling Flash Φ 1.2cm*2cm 765 Packing:6/40/6","Dinosaur Eggs Φ 1cmX1cm W667 Packing:24/24/12","Fivefold Color Cracker Ball AF1008 Packing:20/20/10","Fivefold Color Cracker Ball W669 Packing:20/20/10","Football Crackers AF3010 Packing:200/12","Hand Thunder AF3007 Packing:30/20","Happy Flower s AF1004 Happy Flower Packing:18/12/6","Hot Flashes AF1007 Packing:6/40/6","lluminador AF1009 Packing:48/6","Pili Cracker Φ 1.2cmX1.2cm 1024 Packing:100/50","Silver Glittering Flower s AF1001 Packing:24/24/6"]
    
    
    
    let fountainConesImageList = ["fountain1","fountain2","fountain3","fountain4","fountain5","fountain6","fountain7","fountain8","fountain9","fountain10"]
    let fountainConesTitlelist = ["3″ Conic Fountain T1515","4″ Conic Fountain T1516","5″Kids At Play AF2082","6″ Conic Fountain T1517","6″ Happy Cone AF2069","7″Assortment Fountain HN89","9″Assortment Fountain HN90","Dancing Butterfly 0902","Happy Silver Flower AF2025","Twitter Glitter 0530B"]
    let fountainConesIdlist = ["3″ Conic Fountain T1515","4″ Conic Fountain T1516","5″Kids At Play AF2082","6″ Conic Fountain T1517","6″ Happy Cone AF2069","7″Assortment Fountain HN89","9″Assortment Fountain HN90","Dancing Butterfly 0902","Happy Silver Flower AF2025","Twitter Glitter 0530B"]
    let fountainConesCategorylist = ["Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains","Fountain & Cones, Fountains"]
    let fountainConesTaglist = ["Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains","Cones, Fountain, Fountains"]
    let fountainConesDetailPageImagelist = ["fountainDetail1","fountainDetail2","fountainDetail3"]
    let fountainConesDeclist = ["3″ Conic Fountain T1515 Packing:60/12","4″ Conic Fountain T1516 Packing:36/6","AF20825 Kids At Play Packing:48/6","6″ Conic Fountain T1517 Packing:24/6","6″ Happy Cone AF2069 Packing:18/4","7″ Assortment Fountain HN89 Packing:18/4","9″ Assortment Fountain HN90 Packing:18/4","0902 Dancing Butterfly Packing:36/6","AF2025 Happy Silver Flower Packing:18/4","0530B Twitter Glitter Packing:18/4"]
    
    
    
    let sparklersImageList = ["sparklers1","sparklers2","sparklers3","sparklers4","sparklers5","sparklers6","sparklers7","sparklers8","sparklers9","sparklers10"]
    let sparklersTitlelist = ["7″ Color Bamboo Sparklers 0740","7″ Color Sparklers 0740","7″ Crackling Sparklers 0787","10″ Color Sparklers 0750","10″ Crackling Sparklers 0790 5pcs","10″ Crackling Sparklers 0790 8pcs","14″ Color Sparklers 0750-14","Giant Sparklers 0784E","Happy Sparklers 0784F","Sparklers 0784A_0784B_0784C_0784"]
    let sparklersIdlist = ["7″ Color Bamboo Sparklers 0740","7″ Color Sparklers 0740","7″ Crackling Sparklers 0787","10″ Color Sparklers 0750","10″ Crackling Sparklers 0790 5pcs","10″ Crackling Sparklers 0790 8pcs","14″ Color Sparklers 0750-14","Giant Sparklers 0784E","Happy Sparklers 0784F","Sparklers 0784A_0784B_0784C_0784"]
    let sparklersCategorylist = ["Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time","Sparklers, Sparklers & Day Time"]
    let sparklersTaglist = ["Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers","Day Time, Sparklers"]
    let sparklersDeclist = ["07407″ Color Bamboo Sparklers 24/12/6","07407″ Color Sparklers 24/12/6","07877″ Crackling Sparklers 24/12/6","075010″ Color Sparklers 24/12/8","079010″ Crackling Sparklers 20/20/5","079010″ Crackling Sparklers 12/12/8","0750-1414″ Color Sparklers 24/12/8","0784E Giant Sparklers 10/10/2","0784F Happy Sparklers 10/10/1","0784A/0784B/0784C/0784DSparklers 6/24/6"]
    let sparklersDetailPageImagelist = ["sparklersDetail1","sparklersDetail2","sparklersDetail3"]

//    var productList = [Product]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Acme Firework"
        rightBarItem.image = UIImage(named:"cartBag")?.withRenderingMode(.alwaysOriginal)
        self.collectionView.delegate = self
        self.hideKeyboard()
        setCategoriesData()
        searchBar.delegate = self
        configureScrollViewForImages()
        configurePageControl()
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        self.searchListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationSetCart()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setCartCount()
    }

    // MARK: - STATIC DATA

    func setCategoriesData() {
        
        var firecrackersList = [Product]()
        var cakeList = [Product]()
        var fountainConesList = [Product]()
        var sparklersList = [Product]()
//        self.searchListTableView.allowsSelection = true

        for i in 0..<cakeImageList.count
        {
            let listValue = Product(id: cakeIdlist[i], images: cakeImageList[i] , tag: cakeTaglist[i], title: cakeTitlelist[i] , userId: "1", category: (cakeCategorylist[i]) ,productDescription : cakeDeclist[i], qty: 0 )
            cakeList.append(listValue)
        }
        for i in 0..<firecrackersImageList.count
        {
            let listValue = Product(id: firecrackersIdlist[i], images: firecrackersImageList[i] , tag: firecrackersTaglist[i], title: firecrackersTitlelist[i] , userId: "1", category: (firecrackersCategorylist[i]) ,productDescription : firecrackersDeclist[i], qty: 0 )
            firecrackersList.append(listValue)
        }
        for i in 0..<sparklersImageList.count
        {
            let listValue = Product(id: sparklersIdlist[i], images: sparklersImageList[i] , tag: sparklersTaglist[i], title: sparklersTitlelist[i] , userId: "1", category: (sparklersCategorylist[i]) ,productDescription : sparklersDeclist[i], qty: 0 )
            sparklersList.append(listValue)
        }
        for i in 0..<fountainConesImageList.count
        {
            let listValue = Product(id: fountainConesIdlist[i], images: fountainConesImageList[i] , tag: fountainConesTaglist[i], title: fountainConesTitlelist[i] , userId: "1", category: (fountainConesCategorylist[i]) ,productDescription : fountainConesDeclist[i], qty: 0 )
            fountainConesList.append(listValue)
        }
        
        for i in 0..<categoryListimagelist.count
        {
            if i == 0
            {
                let categoryValue = Category(id: "1", image: categoryListimagelist[i] , title: categoryListTitlelist[i],product:firecrackersList,detailImage : firecrackersDetailPageImagelist)
                categoryList.append(categoryValue)
            }
            else if i == 1
            {
                let categoryValue = Category(id: "2", image: categoryListimagelist[i] , title: categoryListTitlelist[i],product:cakeList,detailImage : cakeDetailPageImagelist)
                categoryList.append(categoryValue)
            }
            else if i == 2
            {
                let categoryValue = Category(id: "3", image: categoryListimagelist[i] , title: categoryListTitlelist[i],product:fountainConesList,detailImage : fountainConesDetailPageImagelist)
                categoryList.append(categoryValue)
            }
            else{
                let categoryValue = Category(id: "4", image: categoryListimagelist[i] , title: categoryListTitlelist[i],product:sparklersList,detailImage : sparklersDetailPageImagelist)
                categoryList.append(categoryValue)
            }
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectedCategoryButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "OfferProductList", sender: self)
    }
    
     // MARK: -  PAGINATION AND SCROLL TO SCROLL IMAGES
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
        }
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(self.tapPage(sender:)))
        scrollViewTap.numberOfTapsRequired = 1
        self.scrollView.addGestureRecognizer(scrollViewTap)
        self.scrollView.showsHorizontalScrollIndicator = false
        
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
    
    // MARK: - TO CHANGE WHILE CLICKING ON PAGE CONTROL

    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(imagelist.count)
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)

    }

    @objc func tapPage(sender: UIScrollView) {
        print("scrollViewTapped")
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        let imageSelected = UIImage(named: imagelist[Int(pageNumber)])!
        if (pageNumber == 0)
        {
//            playVideo()
        }
        else
        {
//            self.imagePreviewView.image = imageSelected
//            self.imagePreviewBackView.isHidden = false
//            showAnimate()
        }
    }
    
    // MARK: - Button Actions

    @IBAction func cancelButtonAction(_ sender: Any) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.filtered.removeAll()
        self.searchActive = false
        self.searchListTableView.reloadData()
        self.collectionView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        self.collectionView.reloadData()
        self.searchListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true;

        filtered = categoryList.filter({( category : Category) -> Bool in
            return category.title.lowercased().contains(searchText.lowercased())
        })
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.collectionView.reloadData()
        self.searchListTableView.reloadData()
    }

    
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        var categoryValue : Category!
        if(searchActive) {
            categoryValue = filtered[indexPath.row] as Category
        }
        else
        {
            categoryValue = categoryList[indexPath.row] as Category
        }

        if UIScreen.main.nativeBounds.height > 1136 {
            cell.frame.size.width = collectionView.frame.size.width/2 - 8
            if indexPath.row % 2 != 0
            {
                cell.frame.origin.x = collectionView.frame.size.width/2 + 4
            }
            else{
                cell.frame.origin.x = 2
            }
        }

        cell.setValueForCell(category: categoryValue)

        return cell
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchListTableView.isHidden = true
        self.searchBar.resignFirstResponder()
        if segue.identifier == "CategoryProductList"
        {
            let cell = sender as? UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell!)
            let index = indexPath?.row
            var selectedValue : Category!

            if(searchActive) {
                selectedValue = filtered[index!]
            }
            else{
                selectedValue = categoryList[index!]
            }
            if let vc = segue.destination as? ProductListViewController {
                vc.category = selectedValue
            }
        }
        else if segue.identifier == "OfferProductList"
        {
            let selectedValue = categoryList[1]
            if let vc = segue.destination as? ProductListViewController {
                vc.category = selectedValue
            }
        }
    }
    
    // MARK: - tableview delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let categoryValue = filtered[indexPath.row] as Category
        cell.textLabel?.text = categoryValue.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        let categoryValue = filtered[indexPath.row] as Category
        searchBar.text = categoryValue.title
        self.searchBar(self.searchBar, textDidChange: searchBar.text!)
        self.searchListTableView.isHidden = true
    }
}

extension HomeViewController :UIGestureRecognizerDelegate
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(HomeViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
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
        if touch.view?.isDescendant(of: self.collectionView) == true {
            return false
        }

        return true
    }

}


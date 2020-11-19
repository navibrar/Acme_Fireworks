//
//  ViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/18/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        imageView.image = UIImage.init(named:"splash")
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: false)

        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToNextView), userInfo: nil, repeats: false)

//        self.moveToNextView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func changeImage() {
        imageView.image = UIImage.init(named:"welcome")
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.moveToNextView), userInfo: nil, repeats: false)
    }
    @objc func moveToNextView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProjectStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.show(vc, sender: AnyObject.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


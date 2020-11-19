//
//  ProductImageViewController.swift
//  Acme Fireworks
//
//  Created by administrator on 12/20/17.
//  Copyright © 2017 Nvish. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class ProductImageViewController: UIViewController {
    var imageSelected = ""
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showImage()
    {
        imageView.image = UIImage(named: imageSelected)
    }

    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

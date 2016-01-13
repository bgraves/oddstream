//
//  WalkAroundViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class WalkAroundViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var tour: NSDictionary? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage.animatedImageNamed("Oddstream-illustration-step", duration: 4.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegueWithIdentifier("ShowCheckBeaconViewController", sender: self)
    }

    @IBAction func back(_: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}

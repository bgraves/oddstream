//
//  CheckBeaconViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class CheckBeaconViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI / 3.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.delegate = self
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.repeatCount = HUGE
        imageView.layer.addAnimation(rotateAnimation, forKey: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegueWithIdentifier("ShowTextContentViewController", sender: self)
    }
}

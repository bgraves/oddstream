//
//  ImageContentViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class ImageContentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage.init(named: "Oddstream-background")
    }
    
    @IBAction func back(_: AnyObject) {
        navigationController?.popToViewController((navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3])!, animated: true)
    }
}

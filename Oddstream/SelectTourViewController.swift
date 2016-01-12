//
//  SelectTourViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class SelectTourViewController: UIViewController {
    @IBOutlet weak var adultButton: UIButton!
    @IBOutlet weak var kidsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adultButton.layer.borderColor = UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0).CGColor
        kidsButton.layer.borderColor = UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0).CGColor
    }
}


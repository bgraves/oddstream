//
//  TextContentViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class TextContentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBAction func back(_: AnyObject) {
        navigationController?.popToViewController((navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3])!, animated: true)
    }
}

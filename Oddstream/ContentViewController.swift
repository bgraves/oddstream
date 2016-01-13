//
//  ContentViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 13-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    var item: NSDictionary? = nil
    
    @IBAction func back(_: AnyObject) {
        navigationController?.popToViewController((navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3])!, animated: true)
    }
}

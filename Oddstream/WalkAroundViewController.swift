//
//  WalkAroundViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class WalkAroundViewController: UIViewController {
    @IBAction func back(_: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}

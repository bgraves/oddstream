//
//  NavigationController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 13-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return self.topViewController is VideoContentViewController ? [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.Landscape] : UIInterfaceOrientationMask.Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}

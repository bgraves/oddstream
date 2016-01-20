//
//  AppDelegate.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if let image = UIImage(named: "Oddstream-background") {
            UIGraphicsBeginImageContext(CGSize(width: 1.0, height: UIScreen.mainScreen().nativeBounds.size.height))
            image.drawInRect(CGRect(x: 0.0, y: 0.0, width: 1.0, height: UIScreen.mainScreen().nativeBounds.size.height))
            window!.backgroundColor = UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext())
            UIGraphicsEndImageContext();
        }
        
        return true
    }
}


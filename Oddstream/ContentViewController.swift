//
//  ContentViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 13-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    var item: Dictionary<String, AnyObject> = [:]
    var rotateAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI / 3.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.delegate = self
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.repeatCount = HUGE
        imageView.layer.addAnimation(rotateAnimation, forKey: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url: NSURL? = NSURL(string: item["url"] as! String) {
            webView.loadRequest(NSURLRequest.init(URL: url!))
        }
    }
    
    @IBAction func back(_: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            webView.alpha = 1.0
            }) { (Bool) -> Void in
                self.rotateAnimation.repeatCount = 0
        }
    }
}

//
//  SelectTourViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class SelectTourViewController: UIViewController {
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://oddstream.miraclethings.nl/api/oddstream/tours")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                
                if let tours = parsedObject as? NSArray {
                    dispatch_async(dispatch_get_main_queue(), {
                        var y = self.view.bounds.size.height / 2 - CGFloat(tours.count * 50) - CGFloat((tours.count - 1) * 25)
                        
                        for tour in tours {
                            let tourette: NSDictionary = tour as! NSDictionary
                            
                            let button = UIButton.init(type: UIButtonType.Custom)
                            button.frame = CGRect(x: self.view.bounds.size.width * 0.11, y: y, width: self.view.bounds.size.width * 0.78, height: 100)
                            button.titleLabel?.font = UIFont.init(name: "Lekton-Bold", size: 24)
                            button.setTitle(tourette["title"] as? String, forState: UIControlState.Normal)
                            button.setTitleColor(UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0), forState: UIControlState.Normal)
                            button.layer.borderWidth = 2
                            button.layer.borderColor = UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0).CGColor
                            button.addTarget(self, action: "setTour:", forControlEvents: .TouchUpInside)
                            self.view.addSubview(button)
                            
                            self.buttons.append(button)
                            
                            y += 150
                        }
                    })
                }
            } catch {
                
            }
        }
        
        task.resume()
    }
    
    @IBAction func setTour(_: AnyObject) {
        performSegueWithIdentifier("ShowWalkAroundViewController", sender: self)
    }
}


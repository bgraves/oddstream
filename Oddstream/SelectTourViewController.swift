//
//  SelectTourViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class SelectTourViewController: UIViewController {
    var tours: NSArray? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://oddstream.miraclethings.nl/api/oddstream/tours")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                self.tours = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray
                
                if self.tours != nil && self.tours!.count > 0 {
                    dispatch_async(dispatch_get_main_queue(), {
                        var index = 0
                        var y = self.view.bounds.size.height / 2 - CGFloat(self.tours!.count * 50) - CGFloat((self.tours!.count - 1) * 25)
                        
                        for tour in self.tours! {
                            let tourette: NSDictionary = tour as! NSDictionary
                            
                            let button = UIButton.init(type: UIButtonType.Custom)
                            button.tag = index++
                            button.frame = CGRect(x: self.view.bounds.size.width * 0.11, y: y, width: self.view.bounds.size.width * 0.78, height: 100)
                            button.titleLabel?.font = UIFont.init(name: "Lekton-Bold", size: 24)
                            button.setTitle(tourette["title"] as? String, forState: UIControlState.Normal)
                            button.setTitleColor(UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0), forState: UIControlState.Normal)
                            button.layer.borderWidth = 2
                            button.layer.borderColor = UIColor(red:0xf7 / 255.0, green:0xe3 / 255.0, blue:0xdd / 255.0, alpha: 1.0).CGColor
                            button.addTarget(self, action: "setTour:", forControlEvents: .TouchUpInside)
                            self.view.addSubview(button)
                            
                            y += 150
                        }
                    })
                }
            } catch {
                
            }
        }
        
        task.resume()
    }
    
    @IBAction func setTour(button: UIButton) {
        performSegueWithIdentifier("ShowWalkAroundViewController", sender: self.tours![button.tag])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let walkAroundViewController = segue.destinationViewController as! WalkAroundViewController
        walkAroundViewController.tour = sender as? NSDictionary
    }
}


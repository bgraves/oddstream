//
//  WalkAroundViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class WalkAroundViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var tourId: Int = 0
    var tour: Dictionary<String, AnyObject> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage.animatedImageNamed("Oddstream-illustration-step", duration: 4.0)

        let url = NSURL(string: "http://oddstream.miraclethings.nl/api/oddstream/tour?id=\(tourId)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                self.tour = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! Dictionary<String, AnyObject>
            } catch {
                
            }
        }
        
        task.resume()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegueWithIdentifier("ShowContentViewController", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let contentViewController = segue.destinationViewController as! ContentViewController
        contentViewController.item = [ "id": 320, "category": "text", "title": "A text item", "url": "http://oddstream.miraclethings.nl/page/320/a-text-item" ]
    }
    
    @IBAction func back(_: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}

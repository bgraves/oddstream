//
//  TextContentViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class TextContentViewController: ContentViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = item!["title"] as? String
        
        let url = NSURL(string: (item!["url"] as? String)!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.bodyLabel.text = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
        }
        
        task.resume()
    }
}

//
//  PageViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 19-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    var item: Dictionary<String, AnyObject> = [:]
    var parts: Array<Dictionary<String, AnyObject>> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        parts = (item["parts"] as? Array<Dictionary<String, AnyObject>>)!
        
        setViewControllers([ viewControllerAtIndex(0)! ], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }

    @IBAction func back(_: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        if (parts.count == 0 || index < 0 || index >= parts.count) {
            return nil
        }
        
        let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        contentViewController.part = parts[index]
        return contentViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        return parts.indexOf({ $0["id"] as! Int == viewController.part["id"] as! Int })!
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = indexOfViewController(viewController as! ContentViewController)
        
        if (index < 1 || index == NSNotFound) {
            return nil
        }
        
        let nextViewController = viewControllerAtIndex(index - 1)
        return nextViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = indexOfViewController(viewController as! ContentViewController)
        
        if (index >= (parts.count - 1) || index == NSNotFound) {
            return nil
        }
        
        let nextViewController = viewControllerAtIndex(index + 1)
        return nextViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return parts.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

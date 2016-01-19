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
    var contentViewControllers: Array<ContentViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let parts: Array<Dictionary<String, AnyObject>> = (item["parts"] as? Array<Dictionary<String, AnyObject>>)!
        for part in parts {
            let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
            contentViewController.part = part
            contentViewControllers.append(contentViewController)
        }
        setViewControllers([ viewControllerAtIndex(0)! ], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        contentViewControllers = []
    }
    
    @IBAction func back(_: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        if (contentViewControllers.count == 0 || index < 0 || index >= contentViewControllers.count) {
            return nil
        }
        
        return contentViewControllers[index]
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        return contentViewControllers.indexOf(viewController)!
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
        
        if (index >= (contentViewControllers.count - 1) || index == NSNotFound) {
            return nil
        }
        
        let nextViewController = viewControllerAtIndex(index + 1)
        return nextViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

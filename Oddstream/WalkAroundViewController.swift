//
//  WalkAroundViewController.swift
//  Oddstream
//
//  Created by Vesa Halttunen on 12-01-16.
//  Copyright © 2016 FrameStream. All rights reserved.
//

import CoreLocation
import UIKit

class WalkAroundViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var tourId: Int = 0
    var tour: Dictionary<String, AnyObject> = [:]
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage.animatedImageNamed("Oddstream-illustration-step", duration: 4.0)

        locationManager.delegate = self
        if locationManager.respondsToSelector("requestWhenInUseAuthorization") {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()

        let url = NSURL(string: "http://oddstream.miraclethings.nl/api/oddstream/tour?id=\(tourId)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                self.tour = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! Dictionary<String, AnyObject>
            } catch {
            }
            
            for item in self.tour["items"] as! Array<Dictionary<String, AnyObject>> {
                var beacon: Dictionary<String, AnyObject> = item["beacon"] as! Dictionary<String, AnyObject>
                if let uuidString = beacon["uuid"] {
                    if let uuid = NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e") { // uuidString as! String) {
                        if let major = beacon["major"] {
                            if let minor = beacon["minor"] {
                                if let url = item["url"] {
                                    let region = CLBeaconRegion(proximityUUID: uuid, major: UInt16(major as! Int), minor: UInt16(minor as! Int), identifier: url as! String)
                                    self.locationManager.startRangingBeaconsInRegion(region)
                                }
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let contentViewController = segue.destinationViewController as! ContentViewController
        contentViewController.item = sender as! Dictionary<String, AnyObject>
    }
    
    @IBAction func back(_: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        for beacon in beacons {
            if (beacon.rssi > -44) {
                for item in self.tour["items"] as! Array<Dictionary<String, AnyObject>> {
                    var itemBeacon: Dictionary<String, AnyObject> = item["beacon"] as! Dictionary<String, AnyObject>
                    if let uuidString = itemBeacon["uuid"] {
                        if (beacon.proximityUUID.UUIDString == uuidString as! String) {
                            performSegueWithIdentifier("ShowContentViewController", sender: item)
                            break
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
        }
    }
}

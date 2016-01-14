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
    var regions: Array<CLBeaconRegion> = []
    var ranging = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage.animatedImageNamed("Oddstream-illustration-step", duration: 4.0)

        locationManager.delegate = self
        if locationManager.respondsToSelector("requestWhenInUseAuthorization") {
            locationManager.requestWhenInUseAuthorization()
        }

        let url = NSURL(string: "http://oddstream.miraclethings.nl/api/oddstream/tour?id=\(tourId)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            do {
                self.tour = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! Dictionary<String, AnyObject>
            } catch {
            }
            
            for item in self.tour["items"] as! Array<Dictionary<String, AnyObject>> {
                var beacon: Dictionary<String, AnyObject> = item["beacon"] as! Dictionary<String, AnyObject>
                if let uuidString = beacon["uuid"] {
                    if let uuid = NSUUID(UUIDString: uuidString as! String) {
                        if let major = beacon["major"] {
                            if let minor = beacon["minor"] {
                                if let title = beacon["title"] {
                                    let region = CLBeaconRegion(proximityUUID: uuid, major: UInt16(major as! Int), minor: UInt16(minor as! Int), identifier: "\(title).\(uuidString)")
                                    self.regions.append(region)
                                }
                            }
                        }
                    }
                }
            }
            
            self.startRangingBeacons()
        }
        task.resume()
    }
    
    func startRangingBeacons() {
        if (!ranging && regions.count > 0) {
            ranging = true
            locationManager.startUpdatingLocation()
            for region in regions {
                self.locationManager.startRangingBeaconsInRegion(region)
            }
        }
    }
    
    func stopRangingBeacons() {
        if (ranging) {
            for region in regions {
                self.locationManager.stopRangingBeaconsInRegion(region)
            }
            locationManager.stopUpdatingLocation()
            ranging = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        startRangingBeacons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        stopRangingBeacons()
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
            if (beacon.rssi >= -55) {
                for item in self.tour["items"] as! Array<Dictionary<String, AnyObject>> {
                    var itemBeacon: Dictionary<String, AnyObject> = item["beacon"] as! Dictionary<String, AnyObject>
                    if let major = itemBeacon["major"] {
                        if let minor = itemBeacon["minor"] {
                            if (beacon.major == major as! Int && beacon.minor == minor as! Int) {
                                stopRangingBeacons()
                                performSegueWithIdentifier("ShowContentViewController", sender: item)
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        showAlert("Please check your bluetooth settings.")
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
//        showAlert("Please check your bluetooth settings.")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    }
}

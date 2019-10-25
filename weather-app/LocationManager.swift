//
//  LocationManager.swift
//  weather-app
//
//  Created by Olli Pertovaara on 20/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var manager: CLLocationManager?
    var gpsLocation: CLLocation?
    var indicator: UIActivityIndicatorView?
    var group: DispatchGroup?
    var gotResults = false
    
    func getLocation() -> CLLocation {
        self.gotResults = false
        return self.gpsLocation!
    }
    
    func hasUpdatedGPS() -> Bool {
        return self.gotResults
    }
    
    func updateLocation() {
        
        self.manager = CLLocationManager()
        self.manager!.delegate = self
        self.manager!.requestAlwaysAuthorization()
        
        print("updateLocation")
        
        self.gotResults = false
        
        self.manager!.startUpdatingLocation()
        
        //let task = session.dataTask(with: url!, completionHandler: doneFetching);
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.gpsLocation = locations.last
        print(self.gpsLocation)
        
        self.gotResults = true
        
        self.manager!.stopUpdatingLocation()
        
        self.indicator?.stopAnimating()
        self.indicator?.removeFromSuperview()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        self.indicator!.stopAnimating()
        self.indicator!.removeFromSuperview()
        print(error)
    }
}

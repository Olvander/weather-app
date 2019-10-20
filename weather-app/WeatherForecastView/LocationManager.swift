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

class LocationManager: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager?
    var gpsLocation: CLLocation?
    var indicator: UIActivityIndicatorView?
    var group: DispatchGroup?
    var gotResults = false
    
    func getLocation() -> CLLocation {
        return self.gpsLocation!
    }
    
    func updateLocation() {
        
        print("updateLocation")

        self.manager = CLLocationManager()
        self.manager!.delegate = self
        self.manager!.requestAlwaysAuthorization()
        self.manager!.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("JEAH")
        
        self.gotResults = true
        
        self.gpsLocation = locations.last
        self.manager!.stopUpdatingLocation()
        
        self.indicator!.stopAnimating()
        self.indicator!.removeFromSuperview()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        self.indicator!.stopAnimating()
        self.indicator!.removeFromSuperview()
        print(error)
    }
}

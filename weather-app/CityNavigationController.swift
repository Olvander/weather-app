//
//  CityNavigationController.swift
//  weather-app
//
//  Created by Olli Pertovaara on 16/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit

class CityNavigationController: UINavigationController {
    
    var btn: UIButton?
    
    var btn2: UIButton?
  
    var timer: Timer?
    
    var newCityField: UITextField?
   
    @objc
    func changeButtonColorDarker() {
        self.btn!.backgroundColor = UIColor(red: 0, green: 0.82, blue: 0, alpha: 1.0)
        
        self.view.setNeedsDisplay()

        self.timer!.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeButtonColorToGreen), userInfo: nil, repeats: false)
    }
    
    @objc
    func changeButtonColorToGreen() {
        self.btn!.backgroundColor = UIColor.green
        
        self.timer!.invalidate()
        
        self.view.setNeedsDisplay()
    }
    
    // Here a city could be added if the textField is not empty...
    @objc
    func addACityTouchUp() {
        
        setCitySelectedAndAddToList()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeButtonColorDarker), userInfo: nil, repeats: false)
    }
    
    @objc
    func addACityTouchDown() {
        
        self.btn!.backgroundColor = UIColor(red: 0, green: 0.82, blue: 0, alpha: 1.0)
 
        self.view.setNeedsDisplay()
    }
    
    func setCitySelectedAndAddToList() {
        
        if self.newCityField!.text != "" {
            let cityView = self.viewControllers[0] as! CityView
            
            let city = self.newCityField!.text!
            
            var cityIsUniqueOnTheList = false
            
            for loc in cityView.locations {
                if loc.location == city {
                    break
                } else {
                    cityIsUniqueOnTheList = true
                }
            }
            
            if cityIsUniqueOnTheList {
                cityView.locations.insert(Location(location:
                    city), at: cityView.locations.count - 1)
                cityView.tableview.reloadData()
                cityView.selectedLocation = Location(location: city)
                
                cityView.tableView(cityView.tableview, didSelectRowAt: IndexPath(row: cityView.locations.count - 2, section: 0))
            }
        }
    }
    
    @objc
    func removeACityTouchUp() {
        
        removeCityFromList()
        
        /*
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeButtonColorDarker), userInfo: nil, repeats: false)
         */
    }
    
    func removeCityFromList() {
        let cityView = self.viewControllers[0] as! CityView
        cityView.locations.remove(at: cityView.previouslySelectedPath!.row)
        
        cityView.tableview.reloadData()

        cityView.tableview.deselectRow(at: cityView.previouslySelectedPath!, animated: true)
        
        cityView.tableView(cityView.tableview!, didDeselectRowAt: cityView.previouslySelectedPath!)
        
        cityView.selectedLocation = cityView.locations[cityView.previouslySelectedPath!.row - 1]
        
        if cityView.previouslySelectedPath!.row - 1 == 0 {
            self.btn2!.removeFromSuperview()
        }
        
        cityView.tableview.selectRow(at: IndexPath(row: cityView.previouslySelectedPath!.row - 1, section: 0), animated: true, scrollPosition: .none)

        cityView.tableView(cityView.tableview!, didSelectRowAt: IndexPath(row: cityView.previouslySelectedPath!.row - 1, section: 0))
    }
}

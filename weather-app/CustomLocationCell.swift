//
//  CustomLocationCell.swift
//  weather-app
//
//  Created by Olli Pertovaara on 16/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit

class CustomLocationCell: UITableViewCell {
    
    var gpsTimer: Timer?
    var cityTimer: Timer?
    
    @IBOutlet weak var gpsButton: UIButton!
    
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var cityRectangleView: UIView!
    
    @IBAction func onCityTouchUpInside(_ sender: Any) {
        
        //self.gpsTextField
        
        let dictionary: [String:UIView] = ["view": self.cityRectangleView!, "label": city!]
        
        self.cityTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeViewColorBlue(timer:)), userInfo: dictionary, repeats: false)
        
    }
    @IBAction func onCityTouchDown(_ sender: Any) {
        self.cityRectangleView!.backgroundColor = UIColor(red: 0.22, green: 0.72, blue: 0.94, alpha: 0.80)
        self.city!.textColor = UIColor.white
        
    }
    @IBOutlet weak var rectangleView: UIView!
    @IBAction func onGPSClick(_ sender: Any) {
        
        let dictionary: [String:UIView] = ["view": self.rectangleView!, "label": self.gps!]
        
        self.gpsTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeViewColorBlue(timer:)), userInfo: dictionary, repeats: false)
    }
    
    @objc
    func changeViewColorBlue(timer: Timer) {
        
        let dictionary = timer.userInfo as! [String: Any]
        let view = dictionary["view"] as! UIView
        let label = dictionary["label"] as! UILabel
        timer.invalidate()

        view.backgroundColor = UIColor(red: 0.22, green: 0.72, blue: 0.94, alpha: 0.80)
        label.textColor = UIColor.white
        self.setNeedsDisplay()
        
        self.gpsTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeViewColorLighter(timer:)), userInfo: dictionary, repeats: false)
    }
    
    @objc
    func changeViewColorLighter(timer: Timer) {
        
        let dictionary = timer.userInfo as! [String: Any]
        let view = dictionary["view"] as! UIView
        let label = dictionary["label"] as! UILabel
        timer.invalidate()

        view.backgroundColor = UIColor(red: 0.90, green: 0.97, blue: 0.99, alpha: 1.00)
        label.textColor = UIColor.black
        self.setNeedsDisplay()
    }
    
    @IBAction func onGPSTouchDown(_ sender: Any) {

        self.rectangleView!.backgroundColor = UIColor(red: 0.22, green: 0.72, blue: 0.94, alpha: 0.80)
        self.gps!.textColor = UIColor.white
        self.setNeedsDisplay()
    }
    
    @IBOutlet weak var gps: UILabel!
    @IBOutlet weak var city: UILabel!
    
    func configureCityCell(location: Location) {
        self.city.text = location.location
    }
    
    func configureGPSCell(location: Location) {
        self.gps.text = location.location
    }
}

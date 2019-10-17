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
  
    var timer: Timer?
   
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
    
    @objc
    func addACityTouchUp() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeButtonColorDarker), userInfo: nil, repeats: false)
    }
    
    @objc
    func addACityTouchDown() {
        
        self.btn!.backgroundColor = UIColor(red: 0, green: 0.82, blue: 0, alpha: 1.0)
 
        self.view.setNeedsDisplay()
    }
}

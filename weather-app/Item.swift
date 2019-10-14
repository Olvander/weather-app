//
//  Item.swift
//  weather-app
//
//  Created by Olli Pertovaara on 14/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation

import UIKit

struct Item {
    var image: UIImage = UIImage()
    var forecast: String = ""
    var date: String = ""
    
    init(image: UIImage, forecast: String, date: String) {
        self.image = image
        self.forecast = forecast
        self.date = date
    }
}

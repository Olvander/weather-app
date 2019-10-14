//
//  WeatherAPIClient.swift
//  weather-app
//
//  Created by Olli Pertovaara on 14/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit

class WeatherAPIClient {
    func getCellItemData() -> [Item] {
        var array: [Item] = [Item]()
        do {
            let url = URL(string: "https://openweathermap.org/img/wn/02d.png")
            let data = try Data(contentsOf: url!)
            
            let item1 = Item(image: UIImage(data: data)!, forecast: "Rain", date: "date1")
            let item2 = Item(image:UIImage(data: data)!, forecast: "Sunny", date: "date2")
            let item3 = Item(image:UIImage(data: data)!, forecast: "Cloudy", date: "date3")
            let item4 = Item(image: UIImage(data: data)!, forecast: "Misty", date: "date4")
            array.append(item1)
            array.append(item2)
            array.append(item3)
            array.append(item4)
            
        } catch {
            print("an error occurred")
        }
        
        return array
    }
}

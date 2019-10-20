//
//  WeatherAPIClient.swift
//  weather-app
//
//  Created by Olli Pertovaara on 14/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WeatherAPIClient {
    var forecasts = [String]()
    var dates = [String]()
    var images = [UIImage]()
    var temperatures = [String]()
    var group: DispatchGroup?
    var group2: DispatchGroup?
    var doned = false
    var queue: DispatchQueue?
    var queueEmpty = false
    var tableview: UITableView?
    var cityView: CityView?
    var indicator: UIActivityIndicatorView?
    var forecastView: WeatherForecastView?
    
    func getCellItemData(from city: String?, or gps: CLLocation?) -> [Item] {
        var array: [Item] = [Item]()
        
        self.group = DispatchGroup()
        
        self.group!.enter()
        
        let location = self.cityView!.selectedLocation?.location

        let gpsLocation = self.cityView!.gpsLocation
        
        if location == "Use GPS" {
            if let loc = gpsLocation {
                fetchUrl(url: "https://api.openweathermap.org/data/2.5/forecast?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)&units=metric&APPID=a999e5bd758a659bb04ec14a1df4cb0a")
            }
            
        } else if city != nil {
        
            fetchUrl(url: "https://api.openweathermap.org/data/2.5/forecast?q=\(city!),finland&units=metric&APPID=a999e5bd758a659bb04ec14a1df4cb0a")
        } else {
            fetchUrl(url: "https://api.openweathermap.org/data/2.5/forecast?lat=\(gps!.coordinate.latitude)&lon=\(gps!.coordinate.longitude)&units=metric&APPID=a999e5bd758a659bb04ec14a1df4cb0a")

        }
        self.group!.wait()
        
        var i = -1
        while i < self.forecasts.count - 1 && self.forecasts.count != 0 {
            i += 1
            let item = Item(image: self.images[i], forecast: self.forecasts[i], date: self.dates[i])
            array.append(item)
        }
        
        return array
    }
    
    func fetchUrl(url : String) {
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        
        task.resume();
        
    }
    
    func pass(tableview: UITableView) {
        self.tableview = tableview
    }
    
    func pass(cityView: CityView) {
        self.cityView = cityView
    }
    
    func pass(forecastView: WeatherForecastView) {
        self.forecastView = forecastView
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        
        let resstr = String(data: data!, encoding: String.Encoding.utf8)

        if data != nil {
            self.setForeCastDataAndIcons(data: data!)
        }
        
        self.group!.leave()

        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            NSLog(resstr!)
            
            self.tableview!.reloadData()
        })

    }
    
    func setForeCastDataAndIcons(data forecast: Data) {
        
        var jsonObj: NSDictionary?
        
        do {
            jsonObj = try JSONSerialization.jsonObject(with: forecast, options: .mutableContainers) as? NSDictionary
        } catch {
            print("An error occurred serializing the weather forecast data")
        }
        
        if let json = jsonObj {
            
            var icon = ""
            var mainWeather = ""
            var temperature = ""
            var date = ""
            
            if let list = json["list"] as? Array<NSDictionary> {
                
                for listItem in list {
                    
                    if let weather = listItem["weather"] as? Array<NSDictionary> {
                        if let iconText = weather[0]["icon"] as? String {
                            icon = iconText
                        }
                        if let main = weather[0]["main"] as? String {
                            mainWeather = main
                        }
                    }
                    
                    if let main2 = listItem["main"] as? NSDictionary {
                        if let temp = main2["temp"] as? Double {
                            temperature = String(format: "%.1f", temp)
                        }
                    }
                    
                    if let dateInTextFormat = listItem["dt"] as? Double {
                        let dateDate = Date(timeIntervalSince1970: TimeInterval(exactly: dateInTextFormat)!)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm a"
                        formatter.amSymbol = "AM"
                        formatter.pmSymbol = "PM"
                        date = formatter.string(from: dateDate)
                    }
                    if icon != "" && temperature != "" && mainWeather != "" && date != "" {
                        
                        let url = URL(string: "https://openweathermap.org/img/wn/\(icon).png")
                        do {
                            let data = try Data(contentsOf: url!)
                            self.images.append(UIImage(data: data)!)
                            
                        } catch {
                            print("Something went wrong while fetching the url \(url).")
                        }
                        self.forecasts.append("\(mainWeather) \(temperature) C")
                        self.dates.append(date)
                        self.temperatures.append("\(temperature) C")
                    }
                }
            }
        }
    }
}

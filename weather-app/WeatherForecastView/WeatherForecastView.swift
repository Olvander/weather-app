//
//  WeatherForecastView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherForecastView: UITableViewController {
    var weatherForecastIcon: UIImageView?
    @IBOutlet weak var weatherForecastData: UITextView!

    var weatherForecast: [Item] = [Item]()
    
    var indicator: UIActivityIndicatorView?
    
    @IBOutlet weak var tableview: UITableView!
    
    var manager: LocationManager?
    
    var apiClient: WeatherAPIClient?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "5 Day Weather Forecast"
        
        self.view.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 1.00)

        self.tableview!.dataSource = self
        self.tableview!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.indicator = UIActivityIndicatorView()
        self.indicator!.style = .whiteLarge
        self.indicator!.color = UIColor.black
        let parentInsets = self.parent!.view.safeAreaInsets
        
        let top = parentInsets.top
        
        let centerX = self.parent!.view.bounds.width / 2
        let centerY = self.parent!.view.bounds.height / 2 - top
        
        self.indicator!.center = CGPoint(x: centerX, y: centerY)
        self.view.addSubview(self.indicator!)
        self.indicator!.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let apiClient = WeatherAPIClient()
        
        self.tableview.reloadData()
        
        apiClient.pass(tableview: self.tableview!)
        
        let uiNav = self.parent as! UINavigationController
        
        let tabBarController = uiNav.parent as! UITabBarController
        
        let cityNav = tabBarController.viewControllers![2] as! CityNavigationController
        let cityView = cityNav.viewControllers[0] as! CityView
        
        apiClient.pass(cityView: cityView)
        
        apiClient.pass(forecastView: self)
        
        self.apiClient = apiClient
        
        let location = cityView.selectedLocation?.location
        
        if let city = location {
            
            apiClient.getCellItemData(from: city, or: nil)
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getForecast), userInfo: nil, repeats: false)
            
            if self.indicator != nil {
                self.indicator!.stopAnimating()
                self.indicator!.removeFromSuperview()
                self.view.setNeedsDisplay()
            }
        } else {
            
            apiClient.getCellItemData(from: nil, or: nil)
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getForecast), userInfo: nil, repeats: false)
        }
    }
    
    @objc
    func getForecast() {
        
        if self.apiClient!.array!.count != 0 {
            
            self.weatherForecast = apiClient!.array!
            self.apiClient!.array = nil
            
            self.indicator!.stopAnimating()
            self.indicator!.removeFromSuperview()

            self.tableview.reloadData()

        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(getForecast), userInfo: nil, repeats: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(weatherForecast[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherForecast", for: indexPath) as? CustomCell {

            cell.configureCell(item: self.weatherForecast[indexPath.row])
            cell.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 0.0)
            
            return cell
        }
        return UITableViewCell()
    }
}

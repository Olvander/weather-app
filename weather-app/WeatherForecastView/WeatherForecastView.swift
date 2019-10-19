//
//  WeatherForecastView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit

class WeatherForecastView: UITableViewController {
    var weatherForecastIcon: UIImageView?
    @IBOutlet weak var weatherForecastData: UITextView!

    var weatherForecast: [Item] = [Item]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "5 Day Weather Forecast"
        
        self.view.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 1.00)

        self.tableview!.dataSource = self
        self.tableview!.delegate = self
        
        let apiClient = WeatherAPIClient()
        
        apiClient.pass(tableview: self.tableview!)
        
        let uiNav = self.parent as! UINavigationController
        
        let tabBarController = uiNav.parent as! UITabBarController
        
        let cityNav = tabBarController.viewControllers![2] as! CityNavigationController
        let cityView = cityNav.viewControllers[0] as! CityView
        
        apiClient.pass(cityView: cityView)
        
        let location = cityView.selectedLocation?.location
        
        print(location)
        
        if let city = location {
        
            self.weatherForecast = apiClient.getCellItemData(from: city)

            self.tableview!.reloadData()
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
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

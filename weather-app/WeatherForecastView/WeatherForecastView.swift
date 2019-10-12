//
//  WeatherForecastView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit

class WeatherForecastView: UITableViewController {
    
    var weatherForecast = ["rain, 5.0", "sunny, 12.0", "cloudy, 10.0"]
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "5 Day Weather Forecast"

        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(weatherForecast[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherForecast", for: indexPath)
        
        cell.textLabel!.text = self.weatherForecast[indexPath.row]
        
        return cell
    }
}

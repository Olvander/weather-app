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

    var weatherForecast = ["placeholder"] //["rain, 5.0", "sunny, 12.0", "cloudy, 10.0"]
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "5 Day Weather Forecast"

        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUrl(url: "https://api.openweathermap.org/data/2.5/forecast?q=Tampere,finland&units=metric&APPID=a999e5bd758a659bb04ec14a1df4cb0a")
    }
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            NSLog(resstr!)
            if data != nil {
                self.setForeCastDataAndIcons(data: data!)
            }
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
            
        let url = URL(string: "https://openweathermap.org/img/wn/02d.png")
            
        
            do {
                let data = try Data(contentsOf: url!)
                if (self.weatherForecastIcon == nil) {
                    self.weatherForecastIcon = UIImageView(image: UIImage(data: data))
                    
                    self.weatherForecast[0] = "Rain1"
                    
                } else {
                
                    self.weatherForecastIcon!.image = UIImage(data: data)
                    
                    self.weatherForecast.append("Rain2")

                }
                
            } catch {
                print("Something went wrong while fetching the url \(url).")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(weatherForecast[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherForecast", for: indexPath)
        
      
        if self.weatherForecastIcon != nil {
            
            let img = self.weatherForecastIcon!.image
 
            cell.imageView!.image = UIImage(cgImage: img as! CGImage)
        
            cell.textLabel!.text = self.weatherForecast[indexPath.row]
        } else {
            self.weatherForecastIcon = cell.imageView!
        }
        return cell
    }
    
}

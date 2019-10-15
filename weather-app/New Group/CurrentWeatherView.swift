//
//  CurrentWeatherView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit
import CoreGraphics

class CurrentWeatherView: UIViewController {
    
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var runAlready = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Current Weather"
        self.view.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 1.00)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cityView!.layer.cornerRadius = 25
        self.temperatureView!.layer.cornerRadius = 25
        
        self.cityView!.isHidden = true
        self.cityLabel!.isHidden = true
        self.temperatureView!.isHidden = true
        self.temperatureLabel!.isHidden = true
        self.weatherIcon!.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {

        fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?q=Tampere,finland&units=metric&APPID=a999e5bd758a659bb04ec14a1df4cb0a")
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
                self.setLabelsAndIcon(data: data!)
            }
        })
    }
    
    func setLabelsAndIcon(data currentWeather: Data) {
        
        var jsonObj: NSDictionary?
            
        do {
             jsonObj = try JSONSerialization.jsonObject(with: currentWeather, options: .mutableContainers) as? NSDictionary
        } catch {
            print("An error occurred serializing the current weather data")
        }
        
        if let json = jsonObj {
            
            if let name = json["name"] as? String {
                self.cityLabel!.text = name
                self.cityLabel!.sizeToFit()
                
                var frame = CGRect(x: UIScreen.main.bounds.width / 2 - (self.cityLabel!.frame.width + 50) / 2, y: self.weatherIcon!.frame.origin.y - 50 - 8, width: self.cityLabel!.frame.width + 50.0, height: 50.0)
                
                self.cityView!.frame = frame
                self.cityLabel!.center = self.cityView!.center
                self.view.bringSubviewToFront(self.cityLabel!)
            }
            
            if let weather = json["weather"] as? Array<NSDictionary> {
                if let icon = weather[0]["icon"] as? String {
                   
                    let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                    
                    do {
                        let data = try Data(contentsOf: url!)
                        self.weatherIcon!.image = UIImage(data: data)
                    } catch {
                        print("Something went wrong while fetching the url \(url).")
                    }
                }
            }
            
            if let main = json["main"] as? NSDictionary {
                if let temperature = main["temp"] as? Double {
                    self.temperatureLabel!.text = String(format: "%.1f", temperature) + " C"

                    self.temperatureLabel!.sizeToFit()
                    
                    var frame = CGRect(x: UIScreen.main.bounds.width / 2 - (self.temperatureLabel!.frame.width + 50) / 2, y: self.weatherIcon!.frame.origin.y + self.weatherIcon!.frame.height + 8, width: self.temperatureLabel!.frame.width + 50.0, height: 50.0)
                    
                    self.temperatureView!.frame = frame
                   
                    self.temperatureLabel!.center = self.temperatureView!.center
                }
            }
        }
        self.cityView!.isHidden = false
        self.cityLabel!.isHidden = false
        self.temperatureView.isHidden = false
        self.temperatureLabel!.isHidden = false
        self.weatherIcon!.isHidden = false
    }
}






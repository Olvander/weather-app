//
//  CurrentWeatherView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Current Weather"
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
                    self.temperatureLabel!.text = String(format: "%.1f", temperature)
                }
            }
        }
    }
}

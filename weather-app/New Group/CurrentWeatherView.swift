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
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            self.setLabelTexts(data: data!)
        })
    }
    
    func setLabelTexts(data currentWeather: Data) {
        
        var jsonObj: NSDictionary?
        
        do {
             jsonObj = try JSONSerialization.jsonObject(with: currentWeather, options: .mutableContainers) as? NSDictionary
        } catch {
            print("An error occurred serializing the current weather data")
        }
        
        if let json = jsonObj {
            
            if let name = json["name"] as? String {
                cityLabel!.text = name
            }
            if let main = json["main"] as? NSDictionary {
                if let temperature = main["temp"] as? Double {
                    temperatureLabel!.text = String(format: "%.1f", temperature)
                }
             }
        }
    }
}

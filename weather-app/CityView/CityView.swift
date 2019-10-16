//
//  CityView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//


import UIKit

class CityView: UITableViewController {
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "City Selection"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(locations[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "gps", for: indexPath) as? CustomLocationCell {
                
                return cell
            
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as? CustomLocationCell {
                    
                    cell.configureCityCell(location: self.locations[indexPath.row])
                    cell.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 0.0)
                    
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
}

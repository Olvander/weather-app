//
//  CityView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//


import UIKit

class CityView: UITableViewController {
    
    var btn: UIButton?
    
    var selectedLocation: Location?
    
    @IBOutlet weak var tableview: UITableView!
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "City Selection"
        
        self.view.backgroundColor = UIColor(red: 0.20, green: 0.78, blue: 0.95, alpha: 1.00)
        
        self.tableview!.dataSource = self
        self.tableview!.delegate = self
        self.locations.append(Location(location: "Use GPS"))
        
        self.locations.append(Location(location: "Tampere"))
        
        self.tableview!.reloadData()
        
        let btn = UIButton()
        let bounds = self.view.bounds
        let x = bounds.width - 100 - self.parent!.view.safeAreaInsets.right
        let y = bounds.height - 100 - self.parent!.view.safeAreaInsets.bottom
        btn.frame = CGRect(x: x, y: y, width: 80, height: 80)
        btn.setTitle("+", for: .normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 72)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        btn.backgroundColor = UIColor.green
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 40
        
        self.navigationController?.view.addSubview(btn)
        
        self.btn = btn
                
        let cityNavigationController: CityNavigationController = self.navigationController as! CityNavigationController
        
        cityNavigationController.btn = self.btn

        cityNavigationController.btn!.addTarget(cityNavigationController, action: #selector(cityNavigationController.addACityTouchUp), for: UIControl.Event.touchUpInside)
        
        cityNavigationController.btn!.addTarget(cityNavigationController, action: #selector(cityNavigationController.addACityTouchDown), for: UIControl.Event.touchDown)
        
    }
    
    // This function does not work because of overlapping buttons.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(locations[indexPath.row])")
        
        self.selectedLocation = locations[indexPath.row]
        
    }
    
    @objc
    func gpsClicked(sender: UIButton) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        self.selectedLocation = locations[indexPath.row]
    }
    
    @objc
    func cityClicked(sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        self.selectedLocation = locations[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "gps", for: indexPath) as? CustomLocationCell {
                
                cell.configureGPSCell(location: self.locations[indexPath.row])
                
                cell.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.87)
                
                
                // Add a tag to button because it overlaps the cell
                cell.gpsButton!.tag = indexPath.row
                
                // Add a target for the button to get the selected Location
                cell.gpsButton!.addTarget(self, action: #selector(gpsClicked(sender:)), for: .touchUpInside)
                
                return cell
            
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as? CustomLocationCell {
                
                cell.configureCityCell(location: self.locations[indexPath.row])
                cell.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.87)
                
                cell.cityButton!.tag = indexPath.row
                cell.cityButton!.addTarget(self, action: #selector(cityClicked(sender:)), for: .touchUpInside)
                                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

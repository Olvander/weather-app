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
    var btn2: UIButton?
    var newCityCell: CustomLocationCell?
    var previouslySelectedPath: IndexPath?
    
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
        
        self.locations.append(Location(location: "Turku"))
        
        self.locations.append(Location(location: ""))
        
        self.tableview!.reloadData()
        
        createButtons()
        
        let cityNavigationController: CityNavigationController = self.navigationController as! CityNavigationController
        
        cityNavigationController.btn = self.btn

        cityNavigationController.btn!.addTarget(cityNavigationController, action: #selector(cityNavigationController.addACityTouchUp), for: UIControl.Event.touchUpInside)
        cityNavigationController.btn!.addTarget(cityNavigationController, action: #selector(cityNavigationController.addACityTouchDown), for: UIControl.Event.touchDown)
        
        cityNavigationController.btn2 = self.btn2
        cityNavigationController.btn2!.addTarget(cityNavigationController, action: #selector(cityNavigationController.removeACityTouchUp), for: UIControl.Event.touchUpInside)
    }
    
    func createButtons() {
        
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
        
        self.btn = btn
        
        let btn2 = UIButton()
        self.parent!.view.safeAreaInsets.bottom
        btn2.frame = CGRect(x: x, y: y, width: 80, height: 80)
        btn2.setTitle("x", for: .normal)
        btn2.titleLabel!.font = UIFont.systemFont(ofSize: 56)
        btn2.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        btn2.backgroundColor = UIColor.red
        btn2.clipsToBounds = true
        btn2.layer.cornerRadius = 40
        
        self.btn2 = btn2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(locations[indexPath.row])")
        
       if self.selectedLocation != nil && self.selectedLocation!.location != self.locations[indexPath.row].location {
            
            self.tableview.deselectRow(at: self.previouslySelectedPath!, animated: true)
            self.tableView(self.tableview!, didDeselectRowAt: self.previouslySelectedPath!)
        }
        
        self.previouslySelectedPath = indexPath
        
        print("SELECTED ROW")
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomLocationCell
        
        cell.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.85, alpha: 1.00)
        
        if indexPath.row == 0 {
            cell.gps!.textColor = UIColor.white
           
            if self.newCityCell != nil {
                self.newCityCell!.newCityField!.resignFirstResponder()
            }
        } else if indexPath.row == locations.count - 1 {
            self.navigationController?.view.addSubview(self.btn!)
            self.newCityCell = cell
            self.newCityCell!.newCityField!.becomeFirstResponder()
        } else {
            self.navigationController?.view.addSubview(self.btn2!)

            cell.city!.textColor = UIColor.white
           
            if self.newCityCell != nil {
                self.newCityCell!.newCityField!.resignFirstResponder()
            }
        }
        self.selectedLocation = locations[indexPath.row]
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        NSLog("\(locations[indexPath.row])")
        
        print("DE-SELECTED ROW")
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomLocationCell

        cell.backgroundColor = UIColor(red: 0.90, green: 0.97, blue: 0.99, alpha: 1.00)
        
        if indexPath.row == 0 {
            cell.gps!.textColor = UIColor.black
        } else if indexPath.row == locations.count - 1 {
            
            self.btn!.removeFromSuperview()
            
        } else {
            
            self.btn2!.removeFromSuperview()
            
            cell.city!.textColor = UIColor.black
        }
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
                
                cell.selectionStyle = .none
                
                cell.backgroundColor = UIColor(red: 0.90, green: 0.97, blue: 0.99, alpha: 1.00)
                
                return cell
            
            }
        
        } else if indexPath.row == locations.count - 1 {
                
            if let cell = tableView.dequeueReusableCell(withIdentifier: "newCity", for: indexPath) as? CustomLocationCell {
        
                print("WAS NEW CITY")
        
                cell.configureNewCityCell(location: Location(location: ""))
                               
                if cell.tableview == nil {
                    cell.tableview = self.tableview
                }
                
                if cell.cityView == nil {
                    cell.cityView = self
                }
                
                let cityNavigationController: CityNavigationController = self.navigationController as! CityNavigationController
                
                if cityNavigationController.newCityField == nil {
                    
                    cityNavigationController.newCityField = cell.newCityField
                }
                
                cell.selectionStyle = .none
                
                cell.backgroundColor = UIColor(red: 0.90, green: 0.97, blue: 0.99, alpha: 1.00)
                
                return cell
            }
            
        } else {
                
            if let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as? CustomLocationCell {
            
                cell.configureCityCell(location: self.locations[indexPath.row])
                
                cell.selectionStyle = .none
                
                cell.backgroundColor = UIColor(red: 0.90, green: 0.97, blue: 0.99, alpha: 1.00)
                
                return cell
                
            }
        }
        return UITableViewCell()
    }
}

//
//  CustomLocationCell.swift
//  weather-app
//
//  Created by Olli Pertovaara on 16/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit

class CustomLocationCell: UITableViewCell, UITextFieldDelegate {
    
    var gpsTimer: Timer?
    var cityTimer: Timer?
    
    var cityView: CityView?
    var tableview: UITableView?
    

    func viewDidLoad() {
        self.newCityField!.delegate = self
    }
    
    @IBOutlet weak var gps: UILabel!
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var newCityField: UITextField!

    @IBAction func editBeganOnCity(_ sender: Any) {

        if self.cityView!.previouslySelectedPath != nil {
            self.tableview!.deselectRow(at: self.cityView!.previouslySelectedPath!, animated: true)
            self.cityView!.tableView(self.tableview!, didDeselectRowAt: self.cityView!.previouslySelectedPath!)
        }
        
        self.tableview!.selectRow(at: IndexPath(row: self.cityView!.locations.count - 1, section: 0), animated: true, scrollPosition: .none)
        self.cityView!.tableView(self.tableview!, didSelectRowAt: IndexPath(row: self.cityView!.locations.count - 1, section: 0) )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.newCityField!.resignFirstResponder()
    }
    
    func configureGPSCell(location: Location) {
        self.gps.text = location.location
    }
    
    func configureCityCell(location: Location) {
        self.city.text = location.location
    }
    
    func configureNewCityCell(location: Location) {
        self.newCityField.text = ""
    }
}

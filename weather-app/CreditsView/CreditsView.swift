//
//  CreditsView.swift
//  weather-app
//
//  Created by Olli Pertovaara on 10/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import UIKit
import Foundation

class CreditsView: UIViewController {

    @IBAction func oniconixarButtonClick(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.flaticon.com/authors/iconixar")! as URL)
    }
    @IBAction func onFlaticonButtonClick(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.flaticon.com")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Credits"
    }
}

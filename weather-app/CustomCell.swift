//
//  CustomCell.swift
//  weather-app
//
//  Created by Olli Pertovaara on 14/10/2019.
//  Copyright © 2019 Olli Pertovaara. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellForecastText: UILabel!

    @IBOutlet weak var dateView: UILabel!
    
    func configureCell(item: Item) {
        self.cellImage!.image = item.image
        self.cellForecastText!.textColor = UIColor.white
        self.cellForecastText!.text = item.forecast
        self.dateView!.text = item.date
        self.dateView!.textColor = UIColor.white
    }
}

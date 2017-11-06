//
//  WeatherListTableViewCell.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 04/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import UIKit
import Foundation

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView! // No time to implement image download - So left it
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var minTextLabel: UILabel!
    @IBOutlet weak var maxTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var timeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

    func configureWeatherListCell(_ title: String, min: Double, max: Double, date: String) {
        titleTextLabel?.text = title
        minTextLabel?.text = String(format:"%.0f%@", min,"\u{00B0}")
        maxTextLabel?.text = String(format:"%.0f%@", max, "\u{00B0}")
        dateTextLabel?.text = date
    }
   
    func configureHeadshotImageView(_ image: UIImage?) {
        imageView?.backgroundColor = UIColor.randomColor()
        imageView?.image = image?.decompressedImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
    }
}

//
//  List.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import Foundation
import UIKit

class List: NSObject{
    var timeInterval: TimeInterval?
    var imageUrl: UIImage?
    var headshot: String?
    var maxTemparature: Double?
    var minTemparature: Double?
    var weatherTitle: String?
    var dateTxt: String?
    var task: URLSessionTask?
    
    init(timeInterval: TimeInterval? = nil,  headshot: String? = nil, maxTemparature: Double? = 0.0, minTemparature: Double? = 0.0, weatherTitle: String? = nil, dateTxt: String? = nil) {
        self.timeInterval = timeInterval
        self.weatherTitle = weatherTitle
        self.headshot = headshot
        self.dateTxt = dateTxt
        self.maxTemparature = maxTemparature
        self.minTemparature = minTemparature
        
    }
}

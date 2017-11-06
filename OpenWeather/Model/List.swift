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
    
    override init() {
        super.init()
    }
}

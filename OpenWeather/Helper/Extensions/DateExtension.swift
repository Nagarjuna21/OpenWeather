//
//  DateExtension.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import Foundation

extension Date {
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    
    func toStringInYYYYMMDD() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringFromDate = formatter.string(from: self)
        return stringFromDate
    }
    func toStringInHHMMDDslashMMslashYYYY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm dd/MM/yyyy"
        let stringFromDate = formatter.string(from: self)
        return stringFromDate
    }
    
    func toStringInHHMM() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let stringFromDate = formatter.string(from: self)
        return stringFromDate
    }
}

//
//  StringExtension.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 08/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import Foundation

extension String {
    func toDateInYYYYMMDD() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = formatter.date(from: self)
        return dateFromString
    }
}

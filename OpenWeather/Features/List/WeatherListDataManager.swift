//
//  WeatherListDataManager.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import Foundation

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

protocol WeatherListDataManagerDelegate {
    func weatherData(_ data: [List])
    func ApiError()
}

class WeatherListDataManager {
    var delegate: WeatherListDataManagerDelegate?
    var lists = [List]()
    
    func getWeather() {
        NetworkManager.getWeatherDataFromAPI({ [weak self] (results) in
            self?.populateJsonData(results)
            }, failure: { _ in
                self.delegate?.ApiError()
        })
    }
    
    func populateJsonData(_ results: [String: AnyObject]?) {
        var lists = [List]()
        let items = results![JsonResponseKeys.List] as! [AnyObject]
        for item in items {
            let list = List()
            list.timeInterval = item[JsonResponseKeys.DateTime] as? TimeInterval
            list.dateTxt = item[JsonResponseKeys.DateTxt] as? String
            if let weathers = item[JsonResponseKeys.Weather] as? [AnyObject] {
                if let weather = weathers.first {
                    if let imageName = weather[JsonResponseKeys.Icon] as? String {
                        list.headshot = String(format: "%@%@.png", APIKeys.ImageURL,imageName)
                        list.weatherTitle = weather[JsonResponseKeys.Description] as? String
                        
                    }
                }
            }
            list.maxTemparature = item.value(forKeyPath: JsonResponseKeys.Main.TempMax) as? Double
            list.minTemparature = item.value(forKeyPath: JsonResponseKeys.Main.TempMin) as? Double
            lists.append(list)
        }
        lists.sort(by: {$0.timeInterval < $1.timeInterval })
        DispatchQueue.main.async(execute: {
            self.delegate!.weatherData(lists)
        })
    }
}

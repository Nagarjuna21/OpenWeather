//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import Foundation
import Alamofire

let parameters = [Parameter.Key.CityId: Parameter.Value.CityValue,Parameter.Key.AppId: Parameter.Value.AppKey]
let headers = [
    HTTPHeader.Key.contentType: HTTPHeader.Value.contentType,
]

class NetworkManager {
    class func networkActivityIndicatorVisible() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    class func networkActivityIndicatorNotVisible() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    class func getWeatherDataFromAPI(_ success: @escaping (([String: AnyObject]) -> Void), failure: @escaping ((Error) -> Void)) {
        let urlString = APIKeys.BaseUrl + Methods.ForecastDataVersion + escapedParameters(parameters as [String : AnyObject])
        
        Alamofire.request(urlString, parameters: parameters, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            if let results = response.result.value as? [String: AnyObject] {
                DispatchQueue.main.async {
                    //print(results)
                    success(results)
                }
            }
        }
    }
    
    class func escapedParameters(_ parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            /* Escape it */
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
    }
}


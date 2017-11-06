//
//  Utilities.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import UIKit
import CoreTelephony
import SystemConfiguration

func hasCellularCoverage() -> Bool {
    let carrier = CTCarrier()
    if !(carrier.mobileCountryCode != nil) { return false }
    
    return true
}

func isReachacbleToInternet() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags = SCNetworkReachabilityFlags()
    
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
    return (isReachable && !needsConnection)
}

func isNetworkReachableOrHasCellularCoverage() -> Bool {
    return (isReachacbleToInternet() || hasCellularCoverage())
}

func displayAlertWithTitle(_ title: String?, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: Translation.ok, style: .cancel, handler: nil)
    alert.addAction(action)
    
    DispatchQueue.main.async {
        viewController.present(alert, animated: true, completion: nil)
    }
}

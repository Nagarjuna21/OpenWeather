//
//  WeatherListDataProvider.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import UIKit

class WeatherListDataProvider: NSObject {
    
    weak var weatherListDataManager: WeatherListDataManager?
    weak var navigationController: UINavigationController?
    
    lazy var configuration: URLSessionConfiguration = {
        $0.allowsCellularAccess = true
        $0.urlCache = nil
        return $0
    }(URLSessionConfiguration.ephemeral)
    
    lazy var downloader: NetworkDownloader = {
        return NetworkDownloader(configuration: self.configuration)
    }()
    
}

extension WeatherListDataProvider: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let  weatherListDataManager = weatherListDataManager else { return 0 }
        return weatherListDataManager.lists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherListTableViewCell
    }
}

extension WeatherListDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? WeatherListTableViewCell else {
            fatalError("Error with register cell")
        }
        
        guard let model = weatherListDataManager?.lists[indexPath.item] else {
            fatalError("Error with data manager")
        }
        
        var minumCelcius = 0.0
        var maximumCelcius = 0.0
        
        if let minCel = model.minTemparature {
            minumCelcius = minCel - Double(Celsius.Conversion)
        }
        if let maxCel = model.maxTemparature {
            maximumCelcius = maxCel - Double(Celsius.Conversion)
        }
        
        cell.configureWeatherListCell(model.weatherTitle!, min: minumCelcius, max: maximumCelcius, date: model.dateTxt!)
        
        if let timeInterval = model.timeInterval {
            cell.timeTextLabel.text = Date(timeIntervalSince1970: timeInterval).toStringInHHMM()
        }
        // MARK:- Downloading Image from URL Async
        if let image = model.imageUrl {
            cell.configureHeadshotImageView(image)
        } else {
            if model.task == nil {
                cell.configureHeadshotImageView(nil)
                guard let imageUrl = URL(string: model.headshot!) else {
                    return
                }
                model.task = downloader.download(imageUrl) { url in
                    model.task = nil
                    if url == nil { return }
                    guard let data = try? Data(contentsOf: url!) else {return}
                    let image = UIImage(data: data)
                    model.imageUrl = image
                    DispatchQueue.main.async {
                        tableView.reloadRows(at: [indexPath], with: .none)
                        cell.configureHeadshotImageView(model.imageUrl)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let weatherListDataManager = weatherListDataManager else { fatalError() }
        let itemCast = weatherListDataManager.lists[indexPath.row]
        if let task = itemCast.task {
            if task.state == .running {
                task.cancel()
                itemCast.task = nil
            }
        }
    }
}


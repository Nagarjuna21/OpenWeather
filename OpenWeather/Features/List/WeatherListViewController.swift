//
//  WeatherListViewController.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController{

    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var weatherListDataProvider: WeatherListDataProvider!
    lazy var weatherListDataManager = WeatherListDataManager()
    @IBAction func refreshButton(_ sender: Any) {
        configureData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = Translation.navTitle
        configureData()
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}

// MARK:- Configuration
extension WeatherListViewController {
    
    func configureData() {
        if isNetworkReachableOrHasCellularCoverage() {
            NetworkManager.networkActivityIndicatorVisible()
            loadingWeather()
        } else {
            displayNetworkAlert()
        }
    }
    
    func loadingWeather() {
        weatherListDataManager.delegate = self
        weatherListDataManager.getWeather()
    }
    
    func displayNetworkAlert() {
        displayAlertWithTitle(Translation.networkErrorTitle, message: Translation.networkErrorMessage, viewController: self)
    }
    
    func displayApiAlert() {
        displayAlertWithTitle(Translation.apiErrorTitle, message: Translation.apiErrorMessage, viewController: self)
    }
    
    func displayTableView() {
        tableView.dataSource = weatherListDataProvider
        tableView.delegate = weatherListDataProvider
        tableView.estimatedRowHeight = Height.Row
        tableView.rowHeight = Height.Row
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

// MARK:- TrendingListDataManagerDelegate
extension WeatherListViewController: WeatherListDataManagerDelegate {
    
    func weatherData(_ data: [List]) {
        if data.count == Int(Count.Value) {
            displayNetworkAlert()
        } else {
            displayTableView()
            weatherListDataProvider?.weatherListDataManager = weatherListDataManager
            weatherListDataProvider?.weatherListDataManager?.lists = data
            weatherListDataProvider?.navigationController = navigationController
            tableView.reloadData()
        }
        NetworkManager.networkActivityIndicatorNotVisible()
    }
    
    func ApiError() {
        displayApiAlert()
    }
}

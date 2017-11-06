//
//  NetworkDownloader.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 05/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import UIKit
typealias NetworkDownloaderCompletion = (URL?) -> ()

let isMain = false

class NetworkDownloader: NSObject {
    
    let config: URLSessionConfiguration
    let queue = OperationQueue()
    
    lazy var session: URLSession = {
        let q = (isMain ? .main: self.queue)
        let session = URLSession(configuration: self.config, delegate: NetworkDownloader.NetworkDownloaderDelegate(), delegateQueue: q)
        return session
    }()
    
    init(configuration config: URLSessionConfiguration) {
        self.config = config
        super.init()
    }
    
    @discardableResult
    func download(_ url: URL, completionHandler ch: @escaping NetworkDownloaderCompletion) -> URLSessionTask {
        
        let request = NSMutableURLRequest(url: url)
        URLProtocol.setProperty(ch as Any, forKey: "ch", in: request)
        let task = self.session.downloadTask(with: request as URLRequest)
        task.resume()
        
        return task
    }
    
    private class NetworkDownloaderDelegate: NSObject, URLSessionDownloadDelegate {
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo url: URL) {
            
            guard let request = downloadTask.originalRequest else {
                return
            }
            
            let ch = URLProtocol.property(forKey: "ch", in: request) as! NetworkDownloaderCompletion
            
            if isMain {
                ch(url)
            } else {
                DispatchQueue.main.sync {
                    ch(url)
                }
            }
        }
        
        deinit {
            print("farewell from Delegate")
        }
    }
    
    deinit {
        print("farewell from NetworkDownloader")
        self.session.invalidateAndCancel()
    }
    
}



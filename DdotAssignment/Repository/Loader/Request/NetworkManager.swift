//
//  NetworkManager.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
import SystemConfiguration

internal class NetworkManager {

    private var session = URLSession()
    private var task: URLSessionDataTask?
    public var reachability: ReachabilityProtocol?

    func getRequestAsync(from url: URL, dataReceived: @escaping (Data?, DataLoaderErrors?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        if reachability?.isConnectedToNetwork() ?? false {
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        task = session.dataTask(with: url) { (data, response, error) in
            guard let receivedData = data else {
                dataReceived(nil, .requestFailed)
                return
            }
            let receivedDataAsString = receivedData.base64EncodedString()
            let receivedDataAfterConvert = Data(base64Encoded: receivedDataAsString)
            if let httpURLResponse = (response as? HTTPURLResponse) {
                if httpURLResponse.statusCode == 200 {
                    dataReceived(receivedDataAfterConvert, nil)
                }
                else {
                    if httpURLResponse.statusCode == 404 {
                        dataReceived(nil, .urlNotFound)
                    }
                }
            }
            else {
                dataReceived(nil, .requestFailed)
            }
        }
        task?.resume()
        }
        else {
            dataReceived(nil, .noNetwork)
        }
    }

    func cancelDownload() {
        task?.cancel()
    }

    func resumeDownload() {
        task?.resume()
    }
    func clearCache() {
        session.reset {
        }
    }
}

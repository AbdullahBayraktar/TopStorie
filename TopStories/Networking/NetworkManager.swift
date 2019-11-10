//
//  NetworkManager.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

typealias RequestCompletion = (Data?, Error?) -> Void

final class NetworkManager: NSObject {
    
    private enum Constant {
        static let baseURL = "https://api.nytimes.com/svc/topstories/v2/"
        static let apiKey = "api-key"
        static let apiKeyValue = "GPKBVNVwmQUIOElQZlNgEYtEA9uaGvSj"
    }
    
    /// Instance of network manager
    static let shared = NetworkManager()
    
    /// URL session
    private lazy var urlSession: URLSession = {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default,
                                    delegate: self,
                                    delegateQueue: nil)
        return urlSession
    }()
    
    /// Makes get request
    ///
    /// - Parameters:
    ///   - requestModel: request model conforms to Encodable
    ///   - urlPath: request url path
    ///   - completion: Completion block
    public func sendRequest(requestModel: Encodable?,
                            urlPath: String,
                            completion: @escaping RequestCompletion) {
        
        guard let url = URL(string: Constant.baseURL + urlPath) else {
            return
        }
        
        var requestDictionary = requestModel?.dictionary ?? [:]
        requestDictionary.updateValue(Constant.apiKeyValue, forKey: Constant.apiKey)
        
        var queryItems: [URLQueryItem]? = []
        for (key, value) in requestDictionary {
            queryItems?.append(URLQueryItem(name: key, value: String(describing: value) ))
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        guard let actualUrl = components?.url else {
            return
        }

        let urlRequest = URLRequest(url: actualUrl)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
             return completion(data, error)
        }
        dataTask.resume()
    }
}

// MARK: - URLSessionDelegate

extension NetworkManager: URLSessionDelegate {}


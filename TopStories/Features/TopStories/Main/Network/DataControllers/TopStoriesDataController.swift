//
//  TopStoriesDataController.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

final class TopStoriesDataController: TopStoriesDataProtocol {
    
    private enum Constant {
        static let urlPath = "home.json"
    }
    
    func retrieveTopStories(completion: @escaping TopStoriesRequestCompletion) {
        
        NetworkManager.shared.sendRequest(requestModel: nil, urlPath: Constant.urlPath) { (data, error) in
         
            var response: TopStoriesResponse?
            
            if error == nil,
                let jsonData = data {
                response = try? JSONDecoder().decode(TopStoriesResponse.self, from: jsonData)
            }
            completion(response, error)
        }
    }
}

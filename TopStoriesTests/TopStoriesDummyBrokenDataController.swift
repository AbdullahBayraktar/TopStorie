//
//  TopStoriesDummyBrokenDataController.swift
//  TopStoriesTests
//
//  Created by Abdullah Bayraktar on 10.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

@testable import TopStories

class TopStoriesDummyBrokenDataController: TopStoriesDataProtocol {
    
    func retrieveTopStories(completion: @escaping TopStoriesRequestCompletion) {
        
        let json = """
        {
            "status":
            "copyright": "Copyright (c) 2019 The New York Times Company. All Rights Reserved.",
            "section": "home",
            "last_updated": "2019-11-10T02:27:07-05:00",
            "num_results": 34,
        }
        """.data(using: .utf8)!
        do {
            let response = try JSONDecoder().decode(TopStoriesResponse.self, from: json)
            completion(response, nil)
        } catch {
            // Inspect any thrown errors here.
            print(error.localizedDescription)

            completion(nil, error)
        }

    }
    

}

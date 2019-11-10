//
//  TopStoriesDataProtocol.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

typealias TopStoriesRequestCompletion = (TopStoriesResponse?, Error?) -> Void

protocol TopStoriesDataProtocol {

    /// Retrieves list of top stories
    ///
    /// - Parameters:
    ///   - completion: Completion block
    func retrieveTopStories(completion: @escaping TopStoriesRequestCompletion)
}

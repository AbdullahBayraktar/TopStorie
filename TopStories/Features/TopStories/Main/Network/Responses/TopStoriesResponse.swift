//
//  TopStoriesResponse.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

final class TopStoriesResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {

        case results = "results"
    }
    
    private(set) var stories: [Story]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.stories = try container.decodeIfPresent([Story].self, forKey: .results)
    }
}

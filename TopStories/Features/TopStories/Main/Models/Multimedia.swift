//
//  Multimedia.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 4.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

struct Multimedia: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case format = "format"
        case url = "url"
    }
    
    private(set) var format: String
    private(set) var url: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.format = try container.decode(String.self, forKey: .format)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

//
//  Story.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

struct Story: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case byline = "byline"
        case url = "url"
        case abstract = "abstract"
        case multimedia = "multimedia"
    }
    
    private(set) var title: String
    private(set) var author: String
    private(set) var url: String
    private(set) var abstract: String
    private(set) var multimedia: [Multimedia]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .byline)
        self.url = try container.decode(String.self, forKey: .url)
        self.abstract = try container.decode(String.self, forKey: .abstract)
        self.multimedia = try container.decode([Multimedia].self, forKey: .multimedia)
    }
}

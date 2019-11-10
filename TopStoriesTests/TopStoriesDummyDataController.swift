//
//  TopStoriesDummyDataController.swift
//  TopStoriesTests
//
//  Created by Abdullah Bayraktar on 10.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

@testable import TopStories

class TopStoriesDummyDataController: TopStoriesDataProtocol {
    
    func retrieveTopStories(completion: @escaping TopStoriesRequestCompletion) {
        
        let json = """
        {
            "status": "OK",
            "copyright": "Copyright (c) 2019 The New York Times Company. All Rights Reserved.",
            "section": "home",
            "last_updated": "2019-11-10T02:27:07-05:00",
            "num_results": 34,
            "results": [{
                "section": "U.S.",
                "subsection": "",
                "title": "If Those Were Pictures of You, You Would Understand 2019",
                "abstract": "Two sisters talk candidly about their lives after being sexually abused as children. It has been 10 years, but online photos and videos continue to haunt them.",
                "url": "https://www.nytimes.com/2019/11/09/us/online-child-abuse.html",
                "byline": "By MICHAEL H. KELLER and GABRIEL J.X. DANCE",
                "item_type": "Article",
                "updated_date": "2019-11-09T10:14:36-05:00",
                "created_date": "2019-11-09T08:43:35-05:00",
                "published_date": "2019-11-09T08:43:35-05:00",
                "material_type_facet": "",
                "kicker": "",
                "des_facet": ["Sex Crimes", "Child Abuse and Neglect", "Social Media"],
                "org_facet": [],
                "per_facet": [],
                "geo_facet": [],
                "multimedia": [{
                    "url": "https://static01.nyt.com/images/2019/11/06/multimedia/00exploited-sisters/00exploited-sisters-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "F. and E. are survivors of child sexual abuse. Online images of the crimes are a continual reminder of the horrors the sisters faced.",
                    "copyright": "Kholood Eid for The New York Times"
                }]
            }]
        }
        """.data(using: .utf8)!
        let response = try? JSONDecoder().decode(TopStoriesResponse.self, from: json)

        completion(response, nil)
    }
    

}

//
//  TopStoriesDataControllerTests.swift
//  TopStoriesTests
//
//  Created by Abdullah Bayraktar on 10.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import XCTest

@testable import TopStories

final class TopStoriesDataControllerTests: XCTestCase {

    func testRetrieveTopStoriesResponse() {
        let dataController = TopStoriesDataController()
        dataController.retrieveTopStories { response, _ in
            guard let response = response as? TopStoriesResponse else {
                XCTFail("Response class is not supported")
                return
            }

            guard response.stories != nil else {
                XCTFail("Story list is empty")
                return
            }
        }
    }
    
    func testStoryModel() {
        let json = """
        {
            "title": "climate change",
            "byline": "byline",
            "url": "https://www.nytimes.com/2019/11/09/style/self-care/collagen-benefits.htm",
            "abstract": "abstract",
            "multimedia": [{
                "url": "",
                "format": "Standard Thumbnail",
                "height": 75,
                "width": 75,
                "type": "image",
                "subtype": "photo",
                "caption": "An outlaw gold miner on the Indonesian island of Sumbawa examining a nugget of gold combined with toxic mercury, which is used to extract the precious metal from crushed ore.",
                "copyright": "Adam Dean for The New York Times"
            }]
        }
        """.data(using: .utf8)!
        
        let story = try! JSONDecoder().decode(Story.self, from: json)
        
        XCTAssertEqual(story.title, "climate change")
        XCTAssertNotEqual(story.title, "climate change ")
        XCTAssertEqual(story.author, "byline")
        XCTAssertEqual(story.url, "https://www.nytimes.com/2019/11/09/style/self-care/collagen-benefits.htm")
        XCTAssertEqual(story.abstract, "abstract")
        // TODO: Check multimedia
    }
}

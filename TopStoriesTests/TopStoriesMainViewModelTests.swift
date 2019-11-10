//
//  TopStoriesMainViewModelTests.swift
//  TopStoriesTests
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

import XCTest
@testable import TopStories

private typealias ViewModel = TopStoriesMainViewModel
private typealias Change = TopStoriesMainState.Change

private class Box {

    let viewModel: ViewModel
    var changes: [Change] = []

    init(with dataController: TopStoriesDataProtocol = TopStoriesDummyDataController()) {
        viewModel = TopStoriesMainViewModel(with: dataController)
        viewModel.stateChangeHandler = { [unowned self] change in
            self.changes.append(change)
        }
    }
}

final class TopStoriesMainViewModelTests: XCTestCase {

    private var error: Error?
    private var box: Box!

    override func setUp() {
        super.setUp()
        reset()
    }

    private func reset() {
        box = Box()
    }
}

// MARK: - Test Cases

extension TopStoriesMainViewModelTests {

    func testFetchTopStoriesSuccessfully() {

        let provider = TopStoriesDummyDataController()
        let box = Box(with: provider)

        box.viewModel.fetchTopStories()

        XCTAssert(box.changes[0] == Change.errorOccurred(nil))
        XCTAssert(box.changes[1] == Change.storiesFetched(true))
    }
    
    func testFetchTopStoriesFailed() {

        let provider = TopStoriesDummyBrokenDataController()
        let box = Box(with: provider)

        box.viewModel.fetchTopStories()
        
        let error = NSError(domain:"",
                            code:-1,
                            userInfo:[ NSLocalizedDescriptionKey: "The data couldn’t be read because it isn’t in the correct format."])
        
        XCTAssert(box.changes[0] == Change.errorOccurred(error))
        XCTAssert(box.changes[1] == Change.storiesFetched(false))
    }
}

// MARK: - Equatable Extensions

extension TopStoriesMainState.Change: Equatable {

    public static func == (lhs: TopStoriesMainState.Change,
                           rhs: TopStoriesMainState.Change) -> Bool {
        switch (lhs, rhs) {
        case let ((.storiesFetched(lhsState)),
                  (.storiesFetched(rhsState))):
            return lhsState == rhsState
        case let ((.errorOccurred(lhsError)),
                  (.errorOccurred(rhsError))):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }
}

//
//  TopStoriesMainViewModel.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

typealias TopStoriesFetchCompletion = (Bool) -> Void

final class TopStoriesMainState {

    /// Possible changes
    enum Change {
        case storiesFetched(Bool)
        case errorOccurred(Error?)
    }

    /// Triggered when change occured
    var onChange: ((TopStoriesMainState.Change) -> Void)?

    /// Stories fetch state
    fileprivate(set) var isTopStoriesRetrieved: Bool = false {
        didSet { onChange?(.storiesFetched(isTopStoriesRetrieved)) }
    }
    
    /// Error state
    fileprivate(set) var error: Error? {
        didSet { onChange?(.errorOccurred(error)) }
    }
}

final class TopStoriesMainViewModel {
    
    /// State
    private let state = TopStoriesMainState()
    
    /// State change handler to trigger
    var stateChangeHandler: ((TopStoriesMainState.Change) -> Void)? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    /// Data controller
    private var dataController: TopStoriesDataProtocol

    /// Count of the stories in toop stories list
    var storiesCount: Int {
        return stories?.count ?? 0
    }
    /// List of stories
    var stories: [Story]?
    
    /// Selected story
    var story: Story?

    /// Initializes a new view model
    ///
    /// - Parameter dataController: Provided data controller
    init(with dataController: TopStoriesDataProtocol) {
        self.dataController = dataController
    }
}

// MARK: - Stories accessers

extension TopStoriesMainViewModel {

    /// Returns story at given index
    ///
    /// - Parameter index: Index of the requested story
    /// - Returns: Story if exists
    func story(at index: Int) -> Story? {
        guard index < storiesCount,
            let stories = stories else { return nil }

        return stories[index]
    }
    
    /// Returns large image url string for the corresponding story
    ///
    /// - Parameter index: Index of the requested story image url
    /// - Returns: URL string
    func largeImageURLStringForStory(at index: Int) -> String {
        
        var largeImageURLString = ""
        guard let story = story(at: index) else {
            return largeImageURLString
        }

        for multimediaItem in story.multimedia {
            if multimediaItem.format == "superJumbo" {
                largeImageURLString = multimediaItem.url
                break
            }
        }
        
        return largeImageURLString
    }
}

// MARK: - Network

extension TopStoriesMainViewModel {

    /// Fetch story  list with given parameters
    ///
    /// - Parameter isInitialFetch: Flag to determine if it is initial fetch
    func fetchTopStories() {

        dataController.retrieveTopStories { [weak self] (response, error) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.state.error = error
            
            guard let response = response else {
                strongSelf.state.isTopStoriesRetrieved = false
                return
            }
            strongSelf.stories = response.stories
            strongSelf.state.isTopStoriesRetrieved = true
        }
    }
}


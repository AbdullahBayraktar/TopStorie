//
//  TopStoriesDetailsViewModel.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

final class TopStoriesDetailState {

    /// Possible changes
    enum Change {
        case details(StoryDetail?)
    }

    /// Triggered when change occured
    var onChange: ((TopStoriesDetailState.Change) -> Void)?

    /// Stories fetch state
    fileprivate(set) var details: StoryDetail? {
        didSet { onChange?(.details(details)) }
    }
}

final class TopStoriesDetailsViewModel {
    
    /// State
    private let state = TopStoriesDetailState()
    
    /// State change handler to trigger
    var stateChangeHandler: ((TopStoriesDetailState.Change) -> Void)? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }

    /// Selected story details
    var storyDetail: StoryDetail?

    /// Initializes a new view model
    ///
    /// - Parameter dataSource: Provided data source
    init(with dataSource: StoryDetail) {
        self.storyDetail = dataSource
    }
    
    func fetchStoryDetails() {
        state.details = storyDetail
    }
}

//
//  TopStoriesDetailsViewController.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

final class TopStoriesDetailsViewController: UIViewController {
    
    // MARK: Enums
    enum Route: String {
        case webView
    }
    
    /// Outlets
    @IBOutlet private weak var storyImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    /// View model
    var viewModel: TopStoriesDetailsViewModel!
    
    var router: Routable?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        bindViewModel()
        viewModel.fetchStoryDetails()
    }
    
    // MARK: - Views
    
    func configureViews() {
        self.title = "Story Detail"
    }
}

// MARK: - Change Handler

private extension TopStoriesDetailsViewController {

    func bindViewModel() {
        viewModel.stateChangeHandler = { [unowned self] change in
            self.applyStateChange(change)
        }
    }

    func applyStateChange(_ change: TopStoriesDetailState.Change) {

        switch change {
        case .details(let storyDetails):
            storyImageView.dowloadFromServer(link: storyDetails?.largeImageURLString ?? "") { }
            titleLabel.text = storyDetails?.title
            authorLabel.text = storyDetails?.author
            descriptionLabel.text = storyDetails?.description
            seeMoreButton.setTitle("See more", for: .normal)
        }
    }
}

// MARK: - Actions

private extension TopStoriesDetailsViewController {
    
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        router?.route(to: Route.webView.rawValue,
                      from: self,
                      parameters: viewModel.storyDetail?.articleURLString)
    }
}

//
//  TopStoriesMainViewController.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

final class TopStoriesMainViewController: UIViewController {
    
    // MARK: Enums
    enum Route: String {
        case storySelection
    }
    
    /// Outlets
    @IBOutlet weak private var tableView: UITableView!

    /// View model
    var viewModel: TopStoriesMainViewModel!
    
    /// Router
    var router: MainRouter!

    // MARK: - Factory

    func initialize() {

        let dataController = TopStoriesDataController()
        viewModel = TopStoriesMainViewModel(with: dataController)
        router = MainRouter()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        prepareViews()
        bindViewModel()

        viewModel.fetchTopStories()
    }
}

// MARK: - Views

private extension TopStoriesMainViewController {

    func prepareViews() {
        // TODO: Add localization if available
        title = "NYT Top Stories"
        tableView.register(cellType: TopStoriesTableViewCell.self, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
    }
}

// MARK: - Change Handler

private extension TopStoriesMainViewController {

    func bindViewModel() {
        viewModel.stateChangeHandler = { [unowned self] change in
            self.applyStateChange(change)
        }
    }

    func applyStateChange(_ change: TopStoriesMainState.Change) {

        switch change {
        case .storiesFetched(let isTopStoriesAvailable):
            if isTopStoriesAvailable {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case .errorOccurred(let error): break
            // TODO: Handle error properly
        }
    }
}

// MARK: - UITableViewDataSource

extension TopStoriesMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.storiesCount
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopStoriesTableViewCell.className, for: indexPath) as! TopStoriesTableViewCell

        guard let story = viewModel.story(at: indexPath.row) else {
            return cell
        }

        cell.configureCell(story: story, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TopStoriesMainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        guard let story = viewModel.story(at: indexPath.row) else {
            return
        }
        
        let parameters = StoryDetail(largeImageURLString: viewModel.largeImageURLStringForStory(at: indexPath.row),
                                     title: story.title,
                                     description: story.abstract,
                                     author: story.author,
                                     articleURLString: story.url)
        
        router.route(to: Route.storySelection.rawValue,
                     from: self,
                     parameters: parameters)
    }
}

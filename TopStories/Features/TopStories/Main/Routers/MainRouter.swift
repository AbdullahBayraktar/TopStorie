//
//  MainRouter.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

final class MainRouter: Routable {
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = TopStoriesMainViewController.Route(rawValue: routeID) else {
            return
        }
        
        switch route {
        case .storySelection:
            let viewController: TopStoriesDetailsViewController = TopStoriesDetailsViewController.instantiate(appStoryboard: .main)
            
            if let parameters = parameters as? StoryDetail {
                let viewModel = TopStoriesDetailsViewModel(with: parameters)
                viewController.viewModel = viewModel
                viewController.router = DetailsRouter()
            }
            
            context.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

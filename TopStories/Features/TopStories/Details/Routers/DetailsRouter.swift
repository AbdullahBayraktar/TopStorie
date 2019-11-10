//
//  DetailsRouter.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 8.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

final class DetailsRouter: Routable {
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = TopStoriesDetailsViewController.Route(rawValue: routeID) else {
            return
        }
        
        switch route {
        case .webView:
            let viewController: DetailsWebViewController = DetailsWebViewController.instantiate(appStoryboard: .main)
            
            if let parameters = parameters as? String {
                let viewModel = DetailsWebViewModel(with: parameters)
                viewController.viewModel = viewModel
            }
            
            context.present(viewController, animated: true, completion: nil)
        }
    }
}

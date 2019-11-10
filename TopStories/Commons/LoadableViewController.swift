//
//  LoadableViewController.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 10.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

class LoadableViewController: UIViewController {

    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    
    func setActivityIndicator(for view: UIView) {
           activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
           activityIndicatorContainer.center.x = view.center.x
           activityIndicatorContainer.center.y = view.center.y
           activityIndicatorContainer.backgroundColor = UIColor.black
           activityIndicatorContainer.alpha = 0.8
           activityIndicatorContainer.layer.cornerRadius = 10
        
           activityIndicator = UIActivityIndicatorView()
           activityIndicator.hidesWhenStopped = true
           activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
           activityIndicator.translatesAutoresizingMaskIntoConstraints = false

           activityIndicatorContainer.addSubview(activityIndicator)
           view.addSubview(activityIndicatorContainer)

           // Constraints
           activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
           activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
       }

    func showActivityIndicator(show: Bool) {
       if show {
           activityIndicator.startAnimating()
       } else {
           activityIndicator.stopAnimating()
           activityIndicatorContainer.removeFromSuperview()
       }
   }
}

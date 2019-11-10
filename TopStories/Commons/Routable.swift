//
//  Routable.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

protocol Routable {
    
    /**
     Routes to the Screen specified by routeId.
     
     - Parameter routeID: Screen to be routed to.
     - Parameter context: The current view controller.
     - Parameter parameters: Any data or model that should be passed to the next view controller.
     */
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
}

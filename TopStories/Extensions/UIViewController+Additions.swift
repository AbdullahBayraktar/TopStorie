//
//  UIViewController+Additions.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 08.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: Storyboard) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

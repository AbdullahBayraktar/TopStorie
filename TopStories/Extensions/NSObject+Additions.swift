//
//  NSObject+Additions.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 8.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}

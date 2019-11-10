//
//  DetailsWebViewModel.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 8.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import Foundation

final class DetailsWebViewModel {

    /// Url string
    var url: String?

    /// Initializes a new view model
    ///
    /// - Parameter dataSource: Provided data source
    init(with dataSource: String) {
        self.url = dataSource
    }
}

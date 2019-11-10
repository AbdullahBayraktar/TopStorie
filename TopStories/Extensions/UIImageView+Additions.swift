//
//  UIImageView+Additions.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 4.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
                completion()
            }
        }.resume()
    }
    
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode, completion: completion)
    }
}

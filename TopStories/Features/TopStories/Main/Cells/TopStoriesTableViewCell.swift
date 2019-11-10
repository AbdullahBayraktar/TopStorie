//
//  TopStoriesTableViewCell.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 3.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit

final class TopStoriesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var smallImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        applyStyling()
    }

    // MARK: - Views
    
    func configureCell(story: Story,
                       at indexPath: IndexPath){

        titleLabel.text = story.title
        authorLabel.text = story.author
        
        if let url = story.multimedia.first?.url {
            imageView?.dowloadFromServer(link: url) { [weak self] in
                self?.setNeedsLayout()
            }
        }
    }
    
    // MARK: - Styling

    private func applyStyling(){
        selectionStyle = .none
    }
}

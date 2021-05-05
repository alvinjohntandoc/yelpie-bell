//
//  ReviewTableViewCell.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit
import Kingfisher

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = 20.5
        }
    }
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.layer.cornerRadius = 10
            scoreLabel.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ review: Review) {
        if let url = review.user.imageURL {
            avatarImageView.kf.setImage(with: URL(string: url),
                                       options:  [.transition(.fade(1.0))])
        } else {
            avatarImageView.image = UIImage(named: "emoji")
        }
        
        reviewLabel.text = review.text
        scoreLabel.text = "\(review.rating)"
        dateLabel.text = review.timeCreated
    }
    
}

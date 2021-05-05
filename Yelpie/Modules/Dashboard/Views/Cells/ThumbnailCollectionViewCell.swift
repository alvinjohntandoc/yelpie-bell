//
//  ThumbnailCollectionViewCell.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit
import Kingfisher

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    func bind(_ thumbnailable: Thumbnailable) {
        
        nameLabel.text = thumbnailable.name
        nameLabel.dropShadow()
        
        let distance = thumbnailable.distance?.toKm ?? ""
        addressLabel.text = "\(thumbnailable.compactLocation) - \(distance)"
        addressLabel.dropShadow()
        
        ratingLabel.text = "Rating: \(thumbnailable.rating)"
        ratingLabel.dropShadow()
        
        coverImageView.kf.setImage(with: URL(string: thumbnailable.imageURL), options:  [.transition(.fade(1.0))])
        coverImageView.layer.cornerRadius = 10
    }
    
}

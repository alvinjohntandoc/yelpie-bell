//
//  SearchTableViewCell.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ thumbnailable: Thumbnailable) {
        nameLabel.text = thumbnailable.name

        let distance = thumbnailable.distance?.toKm ?? ""
        addressLabel.text = "\(thumbnailable.compactLocation) - \(distance)"
        
        ratingLabel.text = "Rating: \(thumbnailable.rating)"
    }

}

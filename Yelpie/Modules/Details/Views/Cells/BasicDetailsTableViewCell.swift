//
//  BasicDetailsTableViewCell.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

class BasicDetailsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ business: Business) {
        
        let distance = business.distance?.toKm ?? ""
        
        titleLabel.text = business.name
        addressLabel.text = String(format: "%@ - %@", business.location.displayAddress.joined(separator: ", "), distance)
        ratingLabel.text = String(format: "Rating: %.2f out of 10", business.rating)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

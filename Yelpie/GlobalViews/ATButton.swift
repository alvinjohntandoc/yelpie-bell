//
//  ATButton.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import UIKit

class ATButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutIfNeeded()
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        
        titleLabel?.font = .avenirFont(ofSize: 12, weight: .black)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemRed
    }

}

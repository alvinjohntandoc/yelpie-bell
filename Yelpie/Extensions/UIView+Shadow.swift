//
//  UIView+Shadow.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
    }
    
}

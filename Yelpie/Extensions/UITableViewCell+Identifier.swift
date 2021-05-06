//
//  UITableViewCell+Identifier.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/6/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

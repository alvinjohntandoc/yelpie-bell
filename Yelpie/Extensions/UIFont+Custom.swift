//
//  UIFont+Custom.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import UIKit

extension UIFont {
    enum AvenirFontWeight: String {
        case bold
        case light
        case medium
        case mediumItalic
        case semiBold
        case black
        case book
        case roman
        
        var fontName: String {
            return "Avenir-\(self.rawValue.capitalizeFirstLetter)"
        }
    }
    
    static func avenirFont(ofSize: CGFloat, weight: AvenirFontWeight = .bold) -> UIFont {
        return UIFont(name: weight.fontName, size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
}


//
//  UINavigationBar+Style.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setStyle(_ style: ATNavigationBarStyle) {
        setBarColor(style.barColor)
        tintColor = style.tintColor
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: style.tintColor]
        isHidden = style.isHidden
    }
    
}

enum ATNavigationBarStyle {
    case white
    case transparent
    case hidden
    
    var barColor: UIColor {
        switch self {
        case .white:
            return .white
        case .transparent:
            return .clear
        case .hidden:
            return .clear
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .white:
            return .black
        case .transparent:
            return .white
        case .hidden:
            return .black
        }
    }
    
    var isHidden: Bool {
        switch self {
        case .white:
            return false
        case .transparent:
            return false
        case .hidden:
            return true
        }
    }
}

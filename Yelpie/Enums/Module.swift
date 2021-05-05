//
//  Module.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import UIKit

enum Module: String {
    case dashboard
    case details
    case search
    
    var storyBoard: UIStoryboard {
        switch self {
        case .dashboard,
             .details,
             .search:
            return UIStoryboard(name: self.rawValue.capitalized, bundle: nil)
        }
    }
    
    var initialController: UIViewController {
        switch self {
        case .dashboard,
             .details,
             .search:
            return storyBoard.instantiateInitialViewController() ?? UIViewController()
        }
    }
}

//
//  BestCategory.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

enum BestCategory: String, CaseIterable {
    case restaurants
    case coffeeShop
    case malls
    
    var title: String {
        switch self {
        case .restaurants:
            return "Best Restaurants"
        case .coffeeShop:
            return "Best Coffee Shops"
        case .malls:
            return "Best Malls"
        }
    }
}

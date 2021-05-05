//
//  SortBy.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation

enum Sort: String, Codable, CaseIterable {
    case rating
    case reviewCount = "review_count"
    case distance
    case bestMatch = "best_match"
    
    var title: String {
        switch self {
        case .rating:
            return "Rating"
        case .reviewCount:
            return "Review Count"
        case .distance:
            return "Distance"
        case .bestMatch:
            return "Best Match"
        }
    }
}
